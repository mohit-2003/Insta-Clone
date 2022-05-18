import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? onPressed;
  final Color backgroungColor;
  final Color borderColor;
  final Color textColor;
  final String text;
  const FollowButton(
      {Key? key,
      this.onPressed,
      required this.backgroungColor,
      required this.borderColor,
      required this.textColor,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 8),
      child: new TextButton(
          onPressed: onPressed,
          child: new Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: backgroungColor,
                border: Border.all(color: borderColor, width: 0.4),
                borderRadius: BorderRadius.circular(6)),
            child: new Text(
              text,
              style:
                  new TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
