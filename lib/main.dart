import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/screens/main_screen.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MultiProvider(
    providers: [
      new ChangeNotifierProvider(
        create: (context) => new UserProvider(),
      )
    ],
    child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Instagram Clone",
        theme: new ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: new MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return MainScreen();
          } else if (snapshot.hasError) {
            return new Center(
              child: new Text("${snapshot.error}"),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          // splash screen
          return new Center(
            child: new CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }
        return new LoginScreen();
      },
    );
  }
}
