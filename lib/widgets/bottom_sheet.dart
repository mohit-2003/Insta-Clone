import 'package:flutter/material.dart';
import 'package:insta_clone/screens/setttings_screen.dart';
import 'package:insta_clone/utils/colors.dart';

class BottomSheets {
  void menuBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape:
            new RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        context: context,
        builder: (context) => new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getItem(new Icon(Icons.settings), "Settings", () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (context) => new SettingScreen(),
                  ));
                }),
                _getItem(new Icon(Icons.update), "Archive", () {}),
                _getItem(
                    new Icon(Icons.insights_outlined), "Get insights", () {}),
                _getItem(
                    new Icon(Icons.local_activity), "Your Activity", () {}),
                _getItem(new Icon(Icons.qr_code_2), "QR Code", () {}),
                _getItem(new Icon(Icons.bookmark_outline), "Saved", () {}),
                _getItem(new Icon(Icons.list), "Close Friends", () {}),
                _getItem(new Icon(Icons.favorite), "Favorites", () {}),
                _getItem(new Icon(Icons.people), "Discover People", () {})
              ],
            ));
  }

  Widget _getItem(Icon icon, String text, VoidCallback? onPressed) {
    return new InkWell(
      onTap: onPressed,
      child: new Container(
        padding: EdgeInsets.all(12),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            new Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: new Text(
                  text,
                  style: new TextStyle(fontSize: 16, color: primaryColor),
                ))
          ],
        ),
      ),
    );
  }
}
