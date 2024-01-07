// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final List likes;
  const Post(
      {required this.description,
      required this.likes,
      required this.uid,
      required this.datePublished,
      required this.postId,
      required this.postUrl,
      required this.profImage,
      required this.username});
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
        "postUrl": postUrl
      };
  //take a doc snapshot and return the data
  static Post formSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      username: snapshot['username'],
      datePublished: snapshot['datePublished'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      uid: snapshot['uid'],
      likes: snapshot['likes'],
    );
  }
}
