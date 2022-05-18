import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/model/user.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/firestore_db_methods.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/widgets/follow_btn.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String userID;
  const ProfileScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData;
  var totalPost = 0;
  bool isFollowing = false;
  bool isLoading = false;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userID)
          .get();
      var postSnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .where("uid", isEqualTo: widget.userID)
          .get();

      setState(() {
        userData = snapshot.data();
        totalPost = postSnapshot.docs.length;
        isFollowing = userData["followers"]
            .contains(FirebaseAuth.instance.currentUser!.uid);
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? new Center(
            child: new CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : new Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: mobileBackgroundColor,
              title: new Text(userData["username"],
                  style: new TextStyle(
                    fontSize: 24,
                  )),
              actions: [
                new IconButton(
                    onPressed: () {},
                    icon: new Icon(
                      FontAwesomeIcons.plus,
                    )),
                new IconButton(
                    onPressed: () {},
                    icon: new Icon(
                      Icons.menu,
                    ))
              ],
            ),
            body: new ListView(children: [
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new CircleAvatar(
                        radius: 48,
                        backgroundImage:
                            new NetworkImage(userData["profileImg"]),
                      ),
                      getColumn(totalPost, "Posts"),
                      getColumn(userData["followers"].length, "Followers"),
                      getColumn(userData["following"].length, "Following"),
                    ],
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: new Text(
                        userData["username"],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                  new Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: new Text(
                        userData["bio"],
                        style: new TextStyle(fontSize: 14),
                      )),
                  FirebaseAuth.instance.currentUser!.uid == widget.userID
                      ? new FollowButton(
                          backgroungColor: mobileBackgroundColor,
                          borderColor: Colors.grey,
                          textColor: primaryColor,
                          text: "Edit profile",
                          onPressed: () {})
                      : isFollowing
                          ? new FollowButton(
                              backgroungColor: mobileBackgroundColor,
                              borderColor: Colors.grey,
                              textColor: primaryColor,
                              text: "Following",
                              onPressed: () async {
                                await new FirestoreDBMethods().followUser(
                                    userID:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    followingID: userData["uid"]);
                                setState(() {
                                  isFollowing = !isFollowing;
                                });
                              })
                          : new FollowButton(
                              backgroungColor: blueColor,
                              borderColor: Colors.transparent,
                              textColor: primaryColor,
                              text: "Follow",
                              onPressed: () async {
                                await new FirestoreDBMethods().followUser(
                                    userID:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    followingID: userData["uid"]);
                                setState(() {
                                  isFollowing = !isFollowing;
                                });
                              },
                            ),
                  new Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  new FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.userID)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return new Center(
                          child: new CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      }

                      return new GridView.builder(
                          shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 1.5,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                                (snapshot.data! as dynamic).docs[index];
                            return new Container(
                              child: new Image(
                                image: new NetworkImage(snap["postUrl"]),
                                fit: BoxFit.cover,
                              ),
                            );
                          });
                    },
                  )
                ],
              ),
            ]),
          );
  }

  Widget getColumn(int i, String s) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Text(
          "$i",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        new Padding(padding: EdgeInsets.only(top: 8), child: new Text(s))
      ],
    );
  }
}
