import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/model/comment.dart';
import 'package:insta_clone/model/post.dart';
import 'package:insta_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreDBMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      {required String description,
      required Uint8List file,
      required String userID,
      required String username,
      required String profileImgUrl}) async {
    String res = "Some error occured";
    try {
      String postUrl = await new StorageMethods()
          .uploadImageToServer(childName: "posts", file: file);
      String postID = new Uuid().v1(); // will generate time based unique id
      Post post = new Post(
          username: username,
          description: description,
          userID: userID,
          postID: postID,
          datePublished: new DateTime.now().toString(),
          profileImg: profileImgUrl,
          postUrl: postUrl,
          likes: []);

      _firestore.collection("posts").doc(postID).set(post.getMap());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String userID, String postID, List likes) async {
    try {
      // disliking post
      if (likes.contains(userID)) {
        await _firestore.collection("posts").doc(postID).update({
          "likes": FieldValue.arrayRemove([userID])
        });
      } else {
        // liking post
        await _firestore.collection("posts").doc(postID).update({
          "likes": FieldValue.arrayUnion([userID])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(
      {required String userID,
      required String username,
      required String postID,
      required String commentText,
      required String profileImgUrl}) async {
    try {
      String commentID = new Uuid().v1();
      Comment comment = new Comment(
          username: username,
          comment: commentText,
          userID: userID,
          commentID: commentID,
          datePublished: new DateTime.now(),
          profileImg: profileImgUrl);
      await _firestore
          .collection("posts")
          .doc(postID)
          .collection("comments")
          .doc(commentID)
          .set(comment.getMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUser(
      {required String userID, required String followingID}) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection("users").doc(userID).get();
      List following = (snapshot.data() as dynamic)["following"];

      if (following.contains(followingID)) {
        await _firestore.collection("users").doc(followingID).update({
          "followers": FieldValue.arrayRemove([userID])
        });

        await _firestore.collection("users").doc(userID).update({
          "following": FieldValue.arrayRemove([followingID])
        });
      } else {
        await _firestore.collection("users").doc(followingID).update({
          "followers": FieldValue.arrayUnion([userID])
        });

        await _firestore.collection("users").doc(userID).update({
          "following": FieldValue.arrayUnion([followingID])
        });
      }
    } catch (e) {}
  }
}
