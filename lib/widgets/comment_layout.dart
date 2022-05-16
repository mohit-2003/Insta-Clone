import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentLayout extends StatefulWidget {
  final data;
  const CommentLayout({Key? key, required this.data}) : super(key: key);

  @override
  State<CommentLayout> createState() => _CommentLayoutState();
}

class _CommentLayoutState extends State<CommentLayout> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: new Row(
          children: [
            new CircleAvatar(
              radius: 16,
              backgroundImage: new NetworkImage(widget.data["profileImg"]),
            ),
            new Expanded(
              child: new Padding(
                padding: EdgeInsets.only(left: 16),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new RichText(
                        text: new TextSpan(children: [
                      new TextSpan(
                          text: widget.data["username"],
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      new TextSpan(text: "  ${widget.data["comment"]}")
                    ])),
                    new Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: new Row(
                        children: [
                          new Text(
                              timeago.format(
                                  (widget.data["datePublished"] as Timestamp)
                                      .toDate()),
                              style: new TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor)),
                          new Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: new InkWell(
                                onTap: () {},
                                child: new Text("Reply",
                                    style: new TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: secondaryColor)),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            new IconButton(
                onPressed: () {},
                icon: new Icon(
                  Icons.favorite_border,
                  size: 16,
                ))
          ],
        ));
  }
}
