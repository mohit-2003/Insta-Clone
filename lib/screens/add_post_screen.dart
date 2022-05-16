import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/model/user.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/firestore_db_methods.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _imgFile;
  bool _isLoading = false;
  final TextEditingController _captionController = new TextEditingController();
  selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => new SimpleDialog(
              title: new Text("Create a Post"),
              children: [
                new SimpleDialogOption(
                  onPressed: (() async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.camera);
                    setState(() {
                      _imgFile = file;
                    });
                  }),
                  child: new Text("Take a Photo"),
                  padding: EdgeInsets.all(20),
                ),
                new SimpleDialogOption(
                  onPressed: (() async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      _imgFile = file;
                    });
                  }),
                  child: new Text("Choose form Gallery"),
                  padding: EdgeInsets.all(20),
                ),
                new SimpleDialogOption(
                  onPressed: (() {
                    Navigator.of(context).pop();
                  }),
                  child: new Text("Cancel"),
                  padding: EdgeInsets.all(20),
                )
              ],
            ));
  }

  postImageToServer(String uid, String username, String profileImgUrl) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreDBMethods().uploadPost(
          description: _captionController.text,
          file: _imgFile!,
          userID: uid,
          username: username,
          profileImgUrl: profileImgUrl);

      if (res == "success") {
        showSnackbar(context, "Image Posted!");
        clearImg();
      } else {
        showSnackbar(context, res);
      }
      setState(() {
        _isLoading = false;
      });
      _captionController.text = "";
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void clearImg() {
    setState(() {
      _imgFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;

    return _imgFile == null
        ? new Center(
            child: new InkWell(
                onTap: () => selectImage(context),
                child: new Text(
                  "Upload",
                  style: new TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: blueColor),
                )))
        : new Scaffold(
            appBar: new AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: new IconButton(
                  onPressed: () => clearImg(),
                  icon: new Icon(Icons.arrow_back)),
              title: new Text("Post to"),
              actions: [
                new TextButton(
                    onPressed: () {
                      postImageToServer(
                          user.uid, user.username, user.profileImg);
                    },
                    child: new Text("Post",
                        style: new TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)))
              ],
            ),
            body: new Column(
              children: [
                _isLoading ? new LinearProgressIndicator() : new Container(),
                new Divider(),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new CircleAvatar(
                      backgroundImage:
                          new NetworkImage(userProvider.getUser.profileImg),
                    ),
                    new SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: new TextField(
                        controller: _captionController,
                        decoration: new InputDecoration(
                            hintText: "Write a caption..",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    new SizedBox(
                      height: 45,
                      width: 45,
                      child: new AspectRatio(
                        aspectRatio: 487 / 451,
                        child: new Container(
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                                  image: new MemoryImage(_imgFile!),
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter)),
                        ),
                      ),
                    ),
                    new Divider()
                  ],
                )
              ],
            ),
          );
  }
}
