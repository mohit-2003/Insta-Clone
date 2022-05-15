class User {
  final String username;
  final String email;
  final String password;
  final String bio;
  final String uid;
  final String profileImg;
  final List followers;
  final List following;

  const User(
      {required this.username,
      required this.email,
      required this.password,
      required this.bio,
      required this.uid,
      required this.profileImg,
      required this.followers,
      required this.following});

  Map<String, dynamic> getMap() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "bio": bio,
      "uid": uid,
      "profileImg": profileImg,
      "followers": [],
      "following": []
    };
  }
}
