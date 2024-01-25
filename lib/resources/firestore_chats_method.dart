import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/messages.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //SEND MESSAGE
  Future<void> sendMessages(String recieverId, String message) async {
    //get user info
    final String currentUseruid = _auth.currentUser!.uid;
    final String currentuserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newmessage = Message(
        senderEmail: currentuserEmail,
        senderId: currentUseruid,
        message: message,
        recieverId: recieverId,
        timestamp: timestamp);
    //construct a chat room between the current user and second user
    List<String> ids = [currentUseruid, recieverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    //add new messages to databases
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newmessage.toMap());
  }

  //GET THE MESSAGE CREATE STREAM
  Stream<QuerySnapshot> getMessages(
      String currentUseruid, String otherUseruid) {
    //chat room id
    List<String> ids = [currentUseruid, otherUseruid];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
