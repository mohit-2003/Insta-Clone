import 'dart:ffi';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadImageToServer(
      {required String childName,
      bool isPost = true,
      required Uint8List file}) async {
    var ref = _firebaseStorage
        .ref()
        .child(childName)
        .child(_firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
