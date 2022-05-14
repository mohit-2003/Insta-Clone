import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signupUser(
      {required String email,
      required String password,
      required String bio,
      required String username,
      required Uint8List profilImage}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty) {
        // creating account
        String profileImgUrl = await new StorageMethods()
            .uploadImageToServer(childName: "ProfileImg", file: profilImage);

        UserCredential credential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        await _firestore.collection("users").doc(credential.user!.uid).set({
          "username": username,
          "email": email,
          "password": password,
          "bio": bio,
          "uid": credential.user!.uid,
          "profileImg": profileImgUrl,
          "followers": [],
          "following": []
        });
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // login method
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // creating account
        UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
