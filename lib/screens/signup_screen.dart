import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/widgets/my_text_field.dart';

import '../utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _bioController = new TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
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
                // for profile
                new Stack(
                  children: [
                    new CircleAvatar(
                      radius: 60,
                      backgroundImage: new NetworkImage(
                          "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                    ),
                    new Positioned(
                      child: new IconButton(
                          onPressed: () {}, icon: new Icon(Icons.add_a_photo)),
                      left: 80,
                      bottom: -10,
                    )
                  ],
                ),
                new SizedBox(
                  height: 24,
                ),
                // for user name
                new MyTextField(
                    textEditingController: _usernameController,
                    hintText: "Enter Your Username",
                    keyboardType: TextInputType.text),
                new SizedBox(
                  height: 24,
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
                // for bio
                new MyTextField(
                    textEditingController: _bioController,
                    hintText: "Enter Your Bio",
                    keyboardType: TextInputType.text),
                new SizedBox(
                  height: 24,
                ),
                new GestureDetector(
                  onTap: () {},
                  child: new Container(
                    child: new Text("Sign up"),
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
                      child: new Text("Already have an account?"),
                    ),
                    new GestureDetector(
                      onTap: () {},
                      child: new Container(
                        padding: new EdgeInsets.symmetric(vertical: 8),
                        child: new Text(
                          "Log in",
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
