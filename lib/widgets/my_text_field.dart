import 'dart:ffi';

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType keyboardType;

  const MyTextField(
      {Key? key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final outlinedBorder =
        new OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return new TextField(
      controller: textEditingController,
      decoration: new InputDecoration(
          hintText: hintText,
          border: outlinedBorder,
          focusedBorder: outlinedBorder,
          enabledBorder: outlinedBorder,
          filled: true,
          contentPadding: new EdgeInsets.all(8)),
      keyboardType: keyboardType,
      obscureText: isPass,
    );
  }
}
