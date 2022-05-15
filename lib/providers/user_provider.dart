import 'package:flutter/cupertino.dart';
import 'package:insta_clone/model/user.dart';
import 'package:insta_clone/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  User get getUser => _user!;

  final AuthMethods _authMethods = new AuthMethods();

  Future<void> refreshUser() async {
    _user = await _authMethods.getCurrentUserDetails();
    notifyListeners();
  }
}
