import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:insta_clone/utils/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: new AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: new IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: new Icon(
            Icons.arrow_back,
            size: 26,
          ),
        ),
        title: new Text(
          "Settings",
          style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: new Container(
        // padding: EdgeInsets.symmetric(horizontal: 16),
        child: new Column(
          children: [
            // search
            new Container(),
            _createItem(
                "Follow and invite friends",
                new Icon(
                  Icons.person_outline_sharp,
                ),
                () {}),
            _createItem(
                "Notifications", new Icon(Icons.notifications_none), () {}),
            _createItem("Creator", new Icon(Icons.person_add), () {}),
            _createItem("Privacy", new Icon(Icons.lock), () {}),
            _createItem("Security", new Icon(Icons.security), () {}),
            _createItem("Ads", new Icon(Icons.insights), () {}),
            _createItem("Account", new Icon(Icons.account_box_rounded), () {}),
            _createItem("Help", new Icon(Icons.help), () {}),
            _createItem("About", new Icon(Icons.info_outline), () {}),
            _createItem("Theme", new Icon(Icons.mode), () {}),
          ],
        ),
      ),
    );
  }

  Widget _createItem(String text, Icon icon, VoidCallback? onPressed) {
    return new Padding(
      padding: EdgeInsets.all(12),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          new Container(
              padding: EdgeInsets.only(left: 8),
              child: new Text(text, style: new TextStyle(fontSize: 16)))
        ],
      ),
    );
  }
}
