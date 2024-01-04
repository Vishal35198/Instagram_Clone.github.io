import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final Authmethods _authmethods = Authmethods();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    //actually reading the data from the user
    User user = await _authmethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
