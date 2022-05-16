import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = new TextEditingController();
  bool isUserShowing = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: mobileBackgroundColor,
        title: new TextFormField(
          controller: searchController,
          decoration: new InputDecoration(
              icon: new Icon(Icons.search),
              hintText: "Search",
              border: InputBorder.none),
          onChanged: (_) {
            setState(() {
              isUserShowing = true;
            });
          },
        ),
      ),
      body: !isUserShowing
          ? new FutureBuilder(
              future: FirebaseFirestore.instance.collection("posts").get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return new Center(
                    child: new CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                return new StaggeredGridView.countBuilder(
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  crossAxisCount: 3,
                  itemCount: snapshot.data!.docs.length,
                  staggeredTileBuilder: (index) => StaggeredTile.count(
                      (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                  itemBuilder: (context, index) {
                    return new Image.network(
                        snapshot.data!.docs[index]["postUrl"]);
                  },
                );
              },
            )
          : new StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("username",
                      isGreaterThanOrEqualTo: searchController.text)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return new Center(
                    child: new CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return new ListTile(
                        leading: new CircleAvatar(
                          backgroundImage: new NetworkImage(
                              snapshot.data!.docs[index]["profileImg"]),
                        ),
                        title: new Text(snapshot.data!.docs[index]["username"]),
                      );
                    });
              },
            ),
    );
  }
}
