import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/firestore_chats_method.dart';
import 'package:instagram_clone/widgets/chat_bubble.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String recieverEmail;
  final String recieverUid;
  const ChatScreen(
      {super.key, required this.recieverEmail, required this.recieverUid});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessages(
          widget.recieverUid, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    //this is the chat page which will contain the chats
    return Scaffold(
      appBar: AppBar(
          // title: Text('ins'),
          ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildMessageInput()],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageController,
            decoration: InputDecoration(hintText: 'type message'),
          ),
        ),
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 40,
            ))
      ],
    );
  }

  Widget _buildMessageItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    //align our message to right
    var aligment = (data['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          ChatBubble(message: data['message']),
          // Text('${obj.hour} : ${obj.minute}')
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream:
          _chatService.getMessages(_auth.currentUser!.uid, widget.recieverUid),
      builder: (context, snapshot) {
        return ListView(
          children: snapshot.data!.docs
              .map((docs) => _buildMessageItem(docs))
              .toList(),
        );
      },
    );
  }
}
