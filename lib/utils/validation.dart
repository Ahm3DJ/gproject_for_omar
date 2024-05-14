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

bool isAgeValid(String? age) {
  //Accept age from 15 to 100 years old only
  if (age!.contains(RegExp(r'^(1[5-9]|[2-9][0-9]|100)$'))) {
    return true;
  } else {
    return false;
  }
}

bool isUserNameValid(String? userName) {
  //Accept age String whether capital or small letters (accepted string length is 2-10)
  if (userName!.contains(RegExp(r'^[a-zA-Z]{2,10}$'))) {
    return true;
  } else {
    return false;
  }
}

bool isTitleValid(String? title) {
  //Accept age String whether capital or small letters (accepted string length is 2-6)
  if (title!.contains(RegExp(r'^[a-zA-Z]{2,6}$'))) {
    return true;
  } else {
    return false;
  }
}

void getDataFromFirebase() {
  print('Retrieving data from firebase...');
}
