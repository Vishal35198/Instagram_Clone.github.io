import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/chat_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: Align(
            alignment: const FractionalOffset(0.6, 0),
            child: Image.asset(
              'lib/assets/instagram-removebg-preview.png',
              // fit: BoxFit.cover,
              height: 80,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MessageScreen(),
                  ));
                },
                icon: const Icon(Icons.messenger_outline))
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (
              context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  // final post = snapshot.data?.docs[index].data();
                  return Container(
                    margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width > 600
                          ? MediaQuery.of(context).size.width * 0.3
                          : 0,
                      horizontal: MediaQuery.of(context).size.width > 600
                          ? MediaQuery.of(context).size.width * 0.3
                          : 0,
                    ),
                    child: PostCard(
                      snap: snapshot.data?.docs[index],
                    ),
                  );
                },
              );
            }));
  }
}
