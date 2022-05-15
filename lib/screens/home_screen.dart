import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/widgets/post_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: mobileBackgroundColor,
        title: new SvgPicture.asset(
          "assets/ic_instagram.svg",
          color: primaryColor,
          height: 32,
        ),
        actions: [
          new IconButton(
              onPressed: () {}, icon: new Icon(Icons.messenger_outline))
        ],
      ),
      body: new PostLayout(),
    );
  }
}
