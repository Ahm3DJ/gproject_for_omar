import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_project2/firebase_options.dart';

bool isEmailValid(String? email) {
  if (email!.contains(RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
    return true;
  } else {
    return false;
  }
}

bool isPasswordValid(String? password) {
  if (password!.contains(
      RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$"))) {
    return true;
  } else {
    return false;
  }
}

bool isLoginSuccessful(bool isEmailValid, bool isPasswordValid) {
  if (isEmailValid == true && isPasswordValid == true) {
    getDataFromFirebase();
    return true;
  } else {
    print('Incorrect email or password, please, try again');
    return false;
  }
}

void getDataFromFirebase() {
  print('Retrieving data from firebase...');
}
