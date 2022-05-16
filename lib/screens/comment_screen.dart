import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/model/user.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/firestore_db_methods.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/widgets/comment_layout.dart';
import 'package:provider/provider.dart';

class CommentScreeen extends StatefulWidget {
  final String postID;
  const CommentScreeen({Key? key, required this.postID}) : super(key: key);

  @override
  State<CommentScreeen> createState() => _CommentScreeenState();
}

class _CommentScreeenState extends State<CommentScreeen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  final TextEditingController commentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: mobileBackgroundColor,
        leading:
            new IconButton(onPressed: () {}, icon: new Icon(Icons.arrow_back)),
        title: new Text("Comments"),
        actions: [
          new IconButton(
              onPressed: () {}, icon: new Icon(FontAwesomeIcons.share))
        ],
      ),
      bottomNavigationBar: new SafeArea(
          child: new Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.only(left: 8, right: 8),
        child: new Row(
          children: [
            new CircleAvatar(
                backgroundImage: new NetworkImage(user.profileImg)),
            new Expanded(
              child: new Padding(
                padding: EdgeInsets.only(left: 16),
                child: new TextField(
                  controller: commentController,
                  decoration: new InputDecoration(
                      hintText: "Comments as ${user.username}..",
                      border: InputBorder.none),
                ),
              ),
            ),
            new InkWell(
              onTap: () {
                validateAndPostCommment(commentController.text, user.uid,
                    user.username, widget.postID, user.profileImg);
                commentController.text = "";
              },
              child: new Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: new Text(
                  "Post",
                  style: new TextStyle(color: Colors.blueAccent),
                ),
              ),
            )
          ],
        ),
      )),
      body: new StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .doc(widget.postID)
            .collection("comments")
            .orderBy("datePublished", descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return new ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return new CommentLayout(data: snapshot.data!.docs[index].data());
            },
          );
        },
      ),
    );
  }

  void validateAndPostCommment(String commentText, String userID,
      String username, String postID, String profileImgUrl) async {
    if (commentText.isNotEmpty) {
      await new FirestoreDBMethods().postComment(
        userID: userID,
        username: username,
        postID: postID,
        commentText: commentText,
        profileImgUrl: profileImgUrl,
      );
    } else {
      // empty text

    }
  }
}
