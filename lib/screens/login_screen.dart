import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/responsive/mobile_screen.dart';
import 'package:instagram_clone/responsive/responsive_screen.dart';
import 'package:instagram_clone/responsive/web_screen.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/image_pick.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authmethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ResposiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreen())));
      //
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navtosignup() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignUpScreen(),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //svg image
            //textfield for email
            //text fireld for password
            //trsnstion k
            const Flexible(
              flex: 1,
              child: SizedBox(),
            ),
            Text_field(
              textEditingController: _emailController,
              hintText: 'Enter Your Email',
              textInputType: TextInputType.emailAddress,
            ),
            Text_field(
              textEditingController: _passwordController,
              hintText: 'password',
              textInputType: TextInputType.text,
              ispass: true,
            ),
            InkWell(
              onTap: loginUser,
              child: Container(
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: blueColor),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Login')),
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
                  child: const Text('Dont have an acoount'),
                ),
                GestureDetector(
                  onTap: () {
                    navtosignup();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('Signup'),
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
