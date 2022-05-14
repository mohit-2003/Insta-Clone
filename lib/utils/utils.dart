import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imgPicker = new ImagePicker();
  XFile? imgFile = await _imgPicker.pickImage(source: source);
  if (imgFile != null) {
    return await imgFile.readAsBytes();
  } else {
    // No Image Selected
  }
}

showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(new SnackBar(content: new Text(message)));
}
