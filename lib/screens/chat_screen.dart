import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/chat.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildUserList(),
    );
  }

  //build the user tile except the current user cause he wont be sending messages to him
  //so we have to take the snap of collection for user for all users
  Widget _userListItems(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (FirebaseAuth.instance.currentUser!.email != data['email']) {
      return ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatScreen(
              recieverEmail: data['email'],
              recieverUid: data['uid'],
            ),
          ));
        },
        title: Text(
          data['email'],
        ),
        subtitle: Text(data['username']),
      );
    }
    return SizedBox();
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return _userListItems(snapshot.data!.docs[index]);
          },
        );
      },
    );
    //building the user list it
  }
}
