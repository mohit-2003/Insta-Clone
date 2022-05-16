import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/screens/add_post_screen.dart';
import 'package:insta_clone/screens/home_screen.dart';
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
                icon: new Icon(Icons.favorite),
                label: null,
                backgroundColor: primaryColor),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.person),
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
            new SearchScreen(),
            new HomeScreen(),
            new AddPostScreen(),
            new Center(child: new Text("Favorite Screen")),
            new Center(child: new Text("Profile Screen"))
          ],
          onPageChanged: (page) {
            setState(() {
              _currIndex = page;
            });
          },
        )));
  }
}
