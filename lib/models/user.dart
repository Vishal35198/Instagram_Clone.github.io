// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final List followers;
  final List following;
  final String photoUrl;
  final String bio;
  const User({
    required this.bio,
    required this.uid,
    required this.username,
    required this.email,
    required this.followers,
    required this.following,
    required this.photoUrl,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "followers": followers,
        "following": following,
        "photoUrl": photoUrl,
        "bio": bio
      };
  //take a doc snapshot and return the data
  static User formSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}
