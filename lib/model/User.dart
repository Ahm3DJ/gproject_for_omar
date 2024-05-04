import 'package:cloud_firestore/cloud_firestore.dart';

class UserDete {
  String password;
  String email;
  String title;
  String username;
  String profileImg;
  String uid;
  String age;
  String situation;
  double balance;
  String phoneNumber;

  UserDete({
    required this.email,
    required this.password,
    required this.title,
    required this.username,
    required this.profileImg,
    required this.uid,
    required this.age,
    required this.situation,
    required this.balance,
      required this.phoneNumber,
  });

  Map<String, dynamic> convert2Map() {
    return {
      "password": password,
      "email": email,
      "title": title,
      "username": username,
      "profileImg": profileImg,
      "uid": uid,
      "age": age,
      "situation": situation,
      "balance": balance,
        "phoneNumber": phoneNumber,
    };
  }

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserDete(
      password: snapshot["password"],
      email: snapshot["email"],
      title: snapshot["title"],
      username: snapshot["username"],
      profileImg: snapshot["profileImg"],
      uid: snapshot["uid"],
      age: snapshot["age"],
      situation: snapshot["situation"],
      balance: snapshot["balance"], phoneNumber:snapshot["phoneNumber"] ,
    );
  }
}
