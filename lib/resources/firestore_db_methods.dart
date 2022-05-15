import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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
          likes: "");

      _firestore.collection("posts").doc(postID).set(post.getMap());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
