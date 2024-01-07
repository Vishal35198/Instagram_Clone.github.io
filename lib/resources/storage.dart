import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storgae = FirebaseStorage.instance;
  //basic overview is
  //take the file from the suer and save it to firestoe and get the download url
  //after uploading to the database
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //adding the image to the firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    //actually doing
    Reference ref =
        _storgae.ref().child(childName).child(_auth.currentUser!.uid);
    //we are checking if it is a post then we are saving it in the
    //form of the post else the profiel pic
    if (isPost) {
      String id = const Uuid().v1();
      ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    // TakeSnapshot snap= await UploadTask;
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
