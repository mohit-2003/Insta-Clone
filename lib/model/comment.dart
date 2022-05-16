import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String comment;
  final String commentID;
  final String userID;
  final String username;
  final datePublished;
  final String profileImg;

  const Comment({
    required this.username,
    required this.comment,
    required this.userID,
    required this.commentID,
    required this.datePublished,
    required this.profileImg,
  });

  Map<String, dynamic> getMap() {
    return {
      "username": username,
      "uid": userID,
      "comment": comment,
      "commentID": commentID,
      "datePublished": datePublished,
      "profileImg": profileImg
    };
  }

  static Comment convertSnapToUser(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return new Comment(
      username: snap["username"],
      userID: snap["uid"],
      comment: snap["comment"],
      commentID: snap["commentID"],
      datePublished: snap["datePublished"],
      profileImg: snap["profileImg"],
    );
  }
}
