import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String userID;
  final String username;
  final String postID;
  final String datePublished;
  final String postUrl;
  final String profileImg;
  final List likes;

  const Post(
      {required this.username,
      required this.description,
      required this.userID,
      required this.postID,
      required this.datePublished,
      required this.profileImg,
      required this.postUrl,
      required this.likes});

  Map<String, dynamic> getMap() {
    return {
      "username": username,
      "description": description,
      "uid": userID,
      "postID": postID,
      "datePublished": datePublished,
      "profileImg": profileImg,
      "postUrl": postUrl,
      "likes": likes
    };
  }

  static Post convertSnapToUser(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return new Post(
        username: snap["username"],
        description: snap["description"],
        userID: snap["uid"],
        postID: snap["postID"],
        datePublished: snap["datePublished"],
        profileImg: snap["profileImg"],
        postUrl: snap["postUrl"],
        likes: snap["likes"]);
  }
}
