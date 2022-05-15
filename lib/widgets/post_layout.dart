import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class PostLayout extends StatelessWidget {
  final Map<String, dynamic> data;
  const PostLayout({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              backgroundImage: new NetworkImage(data["profileImg"]),
            ),
            new Expanded(
              child: new Padding(
                padding: EdgeInsets.only(left: 8),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      data["username"],
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
        new Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: double.infinity,
          child: new Image.network(
            data["postUrl"],
            fit: BoxFit.cover,
          ),
        ),
        new Row(
          children: [
            new IconButton(
                onPressed: () {},
                icon: new Icon(
                  Icons.favorite,
                  color: Colors.red,
                )),
            new IconButton(
                onPressed: () {}, icon: new Icon(Icons.comment_outlined)),
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
              new Text("${data["likes"].length} likes",
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
                          text: data["username"]),
                      new TextSpan(text: "  ${data["description"]}")
                    ])),
              ),
              new InkWell(
                onTap: () {},
                child: new Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: new Text(
                    "View all 18 comments",
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
}
