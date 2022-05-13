import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram Clone",
      theme: new ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: new MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity, // full width
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new SvgPicture.asset(
                  "assets/ic_instagram.svg",
                  height: 64,
                  color: primaryColor,
                ),
                new SizedBox(
                  height: 64,
                )
              ],
            )),
      ),
    );
  }
}
