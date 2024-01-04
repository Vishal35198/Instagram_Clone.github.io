// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as models;
import 'package:instagram_clone/providers/user_provider.dart';

import 'package:provider/provider.dart';
// import 'package:instagram_clone/providers/user_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:instagram_clone/models/user.dart' as models;

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  // String username = "";
  // @override
  // void initState() {
  //   super.initState();
  //   getusername();
  // }

  // void getusername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   // print(snap.data());
  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //     // Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    models.User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(user.username),
      ),
    );
  }
}
