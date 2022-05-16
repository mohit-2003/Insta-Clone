import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/firestore_db_methods.dart';
import 'package:insta_clone/screens/comment_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/widgets/like_animation.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';

class PostLayout extends StatefulWidget {
  final data;
  const PostLayout({Key? key, required this.data}) : super(key: key);

  @override
  State<PostLayout> createState() => _PostLayoutState();
}

class _PostLayoutState extends State<PostLayout> {
  bool isLikeBtnAnimating = false;
  int totalComments = 0;

  @override
  void initState() {
    super.initState();
    getTotalCommmentLength();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: mobileBackgroundColor,
      child: new Column(children: [
        new Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
              .copyWith(right: 0),
          child: new Row(children: [
            new CircleAvatar(
              radius: 16,
              backgroundImage: new NetworkImage(widget.data["profileImg"]),
            ),
            new Expanded(
              child: new Padding(
                padding: EdgeInsets.only(left: 8),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      widget.data["username"],
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            new IconButton(
              onPressed: () {},
              icon: new Icon(Icons.more_vert),
              alignment: Alignment.centerRight,
            )
          ]),
        ),
        new GestureDetector(
          onDoubleTap: () async {
            await new FirestoreDBMethods().likePost(
                user.uid, widget.data["postID"], widget.data["likes"]);

            setState(() {
              isLikeBtnAnimating = true;
            });
          },
          child: new Stack(alignment: Alignment.center, children: [
            new SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: new Image.network(
                widget.data["postUrl"],
                fit: BoxFit.cover,
              ),
            ),
            new AnimatedOpacity(
              duration: new Duration(milliseconds: 200),
              opacity: isLikeBtnAnimating ? 1 : 0,
              child: new LikeAnimator(
                child: new Icon(
                  Icons.favorite,
                  color: primaryColor,
                  size: 100,
                ),
                isAnimating: isLikeBtnAnimating,
                isSmallLike: false,
                duration: new Duration(milliseconds: 400),
                onEnd: () {
                  setState(() {
                    isLikeBtnAnimating = false;
                  });
                },
              ),
            )
          ]),
        ),
        new Row(
          children: <Widget>[
            new LikeAnimator(
              isAnimating: widget.data["likes"].contains(user.uid),
              isSmallLike: true,
              child: new IconButton(
                  onPressed: () async {
                    await new FirestoreDBMethods().likePost(
                        user.uid, widget.data["postID"], widget.data["likes"]);
                  },
                  icon: widget.data["likes"].contains(user.uid)
                      ? new Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : new Icon(
                          Icons.favorite_border,
                        )),
            ),
            new IconButton(
                onPressed: () =>
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new CommentScreeen(
                        postID: widget.data["postID"].toString(),
                      ),
                    )),
                icon: new Icon(Icons.comment_outlined)),
            new IconButton(onPressed: () {}, icon: new Icon(Icons.send)),
            new Expanded(
              child: new Align(
                alignment: Alignment.centerRight,
                child: new IconButton(
                    onPressed: () {}, icon: new Icon(Icons.bookmark_outline)),
              ),
            ),
          ],
        ),
        new Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("${widget.data["likes"].length} likes",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.w800)),
              new Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 8),
                child: new RichText(
                    text: new TextSpan(
                        style: new TextStyle(
                          color: primaryColor,
                        ),
                        children: [
                      new TextSpan(
                          style: new TextStyle(fontWeight: FontWeight.bold),
                          text: widget.data["username"]),
                      new TextSpan(text: "  ${widget.data["description"]}")
                    ])),
              ),
              new InkWell(
                onTap: () {},
                child: new Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: new Text(
                    "View all $totalComments comments",
                    style: new TextStyle(fontSize: 16, color: secondaryColor),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  void getTotalCommmentLength() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.data["postID"])
          .collection("comments")
          .get();
      setState(() {
        totalComments = querySnapshot.docs.length;
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
