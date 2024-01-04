// import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/const/constant.dart';
import 'package:instagram_clone/responsive/mobile_screen.dart';
import 'package:instagram_clone/responsive/responsive_screen.dart';
import 'package:instagram_clone/responsive/web_screen.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/image_pick.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  _LoginScreenState();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickimage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void upload() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authmethods().signUpUser(
        email: _email.text,
        password: _password.text,
        username: _username.text,
        bio: _bio.text,
        file: _image!);
    // print('we moved after the function');
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ResposiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreen())));
    }
  }

  void navtoLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(link),
                      ),
                Positioned(
                    right: 1,
                    bottom: 1,
                    child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(Icons.camera_enhance_rounded,
                            color: Colors.black))),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text_field(
              textEditingController: _username,
              hintText: 'Enter your username',
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            Text_field(
              textEditingController: _email,
              hintText: 'Enter your email',
              textInputType: TextInputType.text,
              // ispass: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Text_field(
              textEditingController: _password,
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              ispass: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Text_field(
              textEditingController: _bio,
              hintText: 'Enter your bio',
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: upload,
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: blueColor),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : const Text('Sign Up')),
            ),
            const SizedBox(
              height: 12,
            ),
            const Flexible(
              flex: 2,
              child: SizedBox(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text('already have an acocount'),
                ),
                GestureDetector(
                  onTap: navtoLogin,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('log in instead'),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}

// ignore: camel_case_types
class Text_field extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool ispass;
  final String hintText;
  final TextInputType textInputType;
  const Text_field({
    super.key,
    required this.textEditingController,
    this.ispass = false, //setting the deafult value
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      obscureText: ispass,
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.solid))),
    );
  }
}
