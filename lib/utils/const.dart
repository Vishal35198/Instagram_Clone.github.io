import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:instagram_clone/models/user.dart';
// import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';

List<Widget> homescreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Center(
    child: Text('Liked'),
  ),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
String hj =
    'https://firebasestorage.googleapis.com/v0/b/instagram-clone-7eeeb.appspot.com/o/profilePics%2FPYRfwcc68nfIPslooY45Gow9A433?alt=media&token=ba9801fb-d930-4955-ae20-53b439af325e';
//  myCircularIndicator = const Center(
//   child: CircularProgressIndicator(
//     color: Colors.white,
//   ),
// );
// var resposiveSize = MediaQuery.of(context).size;
