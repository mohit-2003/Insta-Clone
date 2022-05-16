import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/model/user.dart' as model;
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/screens/add_post_screen.dart';
import 'package:insta_clone/screens/home_screen.dart';
import 'package:insta_clone/screens/profile_screen.dart';
import 'package:insta_clone/screens/search_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = new PageController();
    refreshUserDetails();
  }

  refreshUserDetails() async {
    final UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onNavigationItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return new Scaffold(
        bottomNavigationBar: new CupertinoTabBar(
          currentIndex: _currIndex,
          activeColor: primaryColor,
          inactiveColor: secondaryColor,
          backgroundColor: mobileBackgroundColor,
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: null,
                backgroundColor: primaryColor),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                label: null,
                backgroundColor: primaryColor),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.add_circle),
                label: null,
                backgroundColor: primaryColor),
            new BottomNavigationBarItem(
                icon: _currIndex == 3
                    ? new Icon(Icons.favorite)
                    : new Icon(Icons.favorite_border),
                label: null,
                backgroundColor: primaryColor),
            new BottomNavigationBarItem(
                icon: _currIndex == 4
                    ? new CircleAvatar(
                        radius: 16,
                        backgroundColor: primaryColor,
                        child: new CircleAvatar(
                          radius: 14,
                          backgroundImage: new NetworkImage(user.profileImg),
                        ),
                      )
                    : new CircleAvatar(
                        radius: 14,
                        backgroundImage: new NetworkImage(user.profileImg),
                      ),
                label: null,
                backgroundColor: primaryColor),
          ],
          onTap: (value) => onNavigationItemTapped(value),
        ),
        body: new SafeArea(
            child: new PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            new HomeScreen(),
            new SearchScreen(),
            new AddPostScreen(),
            new Center(child: new Text("Favorite Screen")),
            new ProfileScreen(userID: FirebaseAuth.instance.currentUser!.uid),
          ],
          onPageChanged: (page) {
            setState(() {
              _currIndex = page;
            });
          },
        )));
  }
}
