import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/widgets/my_text_field.dart';

import '../utils/colors.dart';

class LoginScreeen extends StatefulWidget {
  const LoginScreeen({Key? key}) : super(key: key);

  @override
  State<LoginScreeen> createState() => _LoginScreeenState();
}

class _LoginScreeenState extends State<LoginScreeen> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

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
                new Flexible(
                  child: new Container(),
                  flex: 1,
                ),
                new SvgPicture.asset(
                  "assets/ic_instagram.svg",
                  height: 64,
                  color: primaryColor,
                ),
                new SizedBox(
                  height: 64,
                ),
                // for email
                new MyTextField(
                    textEditingController: _emailController,
                    hintText: "Enter Your Email",
                    keyboardType: TextInputType.emailAddress),
                new SizedBox(
                  height: 24,
                ),
                // for password
                new MyTextField(
                  textEditingController: _passController,
                  hintText: "Enter Your Password",
                  keyboardType: TextInputType.text,
                  isPass: true,
                ),
                new SizedBox(
                  height: 24,
                ),
                new GestureDetector(
                  onTap: () {},
                  child: new Container(
                    child: new Text("Log in"),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: new EdgeInsets.symmetric(vertical: 12),
                    decoration: new ShapeDecoration(
                        color: blueColor,
                        shape: new RoundedRectangleBorder(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(4)))),
                  ),
                ),
                new SizedBox(
                  height: 12,
                ),
                new Flexible(
                  child: new Container(),
                  flex: 1,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                      padding: new EdgeInsets.symmetric(vertical: 8),
                      child: new Text("Don't have an account?"),
                    ),
                    new GestureDetector(
                      onTap: () {},
                      child: new Container(
                        padding: new EdgeInsets.symmetric(vertical: 8),
                        child: new Text(
                          "Sign up.",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
