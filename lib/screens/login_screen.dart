import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/screens/main_screen.dart';
import 'package:insta_clone/screens/signup_screen.dart';
import 'package:insta_clone/widgets/my_text_field.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  bool _isLoading = false;
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
                  onTap: () {
                    loginUser();
                  },
                  child: new Container(
                    child: _isLoading
                        ? new Center(
                            child: new CircularProgressIndicator(
                            color: primaryColor,
                            strokeWidth: 3.0,
                          ))
                        : new Text("Log in"),
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
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacement(new MaterialPageRoute(
                          builder: (context) => new SignupScreen(),
                        ));
                      },
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

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await new AuthMethods().loginUser(
        email: _emailController.text, password: _passController.text);

    setState(() {
      _isLoading = false;
    });
    if (res == "success") {
      // succesfully sign up
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (context) => new MainScreen(),
      ));
    } else {
      // showing error
      showSnackbar(context, res);
    }
  }
}
