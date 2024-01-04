import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickimage(ImageSource source) async {
  final ImagePicker imgpicked = ImagePicker();
  XFile? img = await imgpicked.pickImage(source: source);
  if (img != Null) {
    return await img?.readAsBytes();
  }
  print('No image is Selected');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
