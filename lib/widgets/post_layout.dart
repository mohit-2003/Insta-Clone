import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class PostLayout extends StatelessWidget {
  const PostLayout({Key? key}) : super(key: key);

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
              backgroundImage: new NetworkImage(
                  "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
            ),
            new Expanded(
              child: new Padding(
                padding: EdgeInsets.only(left: 8),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      "User1",
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
            "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
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
              new Text("8,596 likes",
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
                          text: "username"),
                      new TextSpan(text: "  Discription")
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
