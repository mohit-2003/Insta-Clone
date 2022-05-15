import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/screens/main_screen.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/utils/utils.dart';
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
  Uint8List? _profileImage;
  bool _isLoading = false;
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
      resizeToAvoidBottomInset: false,
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
                    _profileImage == null
                        ? new CircleAvatar(
                            radius: 60,
                            backgroundImage: new NetworkImage(
                                "https://deejayfarm.com/wp-content/uploads/2019/10/Profile-pic.jpg"),
                          )
                        : new CircleAvatar(
                            radius: 60,
                            backgroundImage: new MemoryImage(_profileImage!),
                          ),
                    new Positioned(
                      child: new IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          icon: new Icon(Icons.add_a_photo)),
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
                  onTap: () {
                    signupUser();
                  },
                  child: new Container(
                    child: _isLoading
                        ? new Center(
                            child: new CircularProgressIndicator(
                            color: primaryColor,
                            strokeWidth: 3.0,
                          ))
                        : new Text("Sign up"),
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
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacement(new MaterialPageRoute(
                          builder: (context) => new LoginScreen(),
                        ));
                      },
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

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _profileImage = image;
    });
  }

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await new AuthMethods().signupUser(
        email: _emailController.text,
        password: _passController.text,
        bio: _bioController.text,
        username: _usernameController.text,
        profilImage: _profileImage!);

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
