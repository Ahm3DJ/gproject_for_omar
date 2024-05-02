import 'package:flutter/material.dart';
import 'package:graduation_project2/firebase/fireStore.dart';
import 'package:graduation_project2/model/User.dart';


class UserProvider with ChangeNotifier {
  UserDete? _userData;
  UserDete? get getUser => _userData;

  refreshUser( ) async {
    UserDete userData = await FireBase().getUserDetails();
    _userData = userData;
    notifyListeners();

    print("11111111111111111111111111111111${userData.email}");
  }
}
