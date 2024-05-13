import 'package:cloud_firestore/cloud_firestore.dart';

class PostData {
  final String profileImg;
  final String username;
  final String description;
  final String imgPost;
  final String uid;
  final String postId;
  final DateTime datePublished;
  final List likes;
  final String quntity;
  final String caption;
  final String price;
  final String title;
  final String prodactName;
  final String typeOfProdact;
  final String phoneNumber;
  final List Likes;

  PostData({
    required this.profileImg,
    required this.username,
    required this.description,
    required this.imgPost,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.likes,
    required this.quntity,
    required this.caption,
    required this.price,
    required this.title,
    required this.prodactName,
    required this.typeOfProdact,
    required this.phoneNumber,
    required this.Likes
  });

// To convert the UserData(Data type) to   Map<String, Object>
  Map<String, dynamic> convert2Map() {
    return {
      "profileImg": profileImg,
      "username": username,
      "description": description,
      "imgPost": imgPost,
      "uid": uid,
      "postId": postId,
      "datePublished": datePublished,
      "likes": likes,
      "quntity": quntity,
      "caption": caption,
      "price": price,
      "title": title,
      "prodactName": prodactName,
      "typeOfProdact": typeOfProdact,
      "phoneNumber": phoneNumber,
      "phoneNumLikesber": Likes,
    };
  }

  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostData(
      profileImg: snapshot["profileImg"],
      username: snapshot["username"],
      description: snapshot["description"],
      imgPost: snapshot["imgPost"],
      uid: snapshot["uid"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      likes: snapshot["likes"],
      quntity: snapshot["quntity"],
      caption: snapshot["caption"],
      price: snapshot["price"],
      title: snapshot["title"],
      prodactName: snapshot["prodactName"],
      typeOfProdact: snapshot["typeOfProdact"],
      phoneNumber: snapshot["phoneNumber"], Likes: snapshot["Likes"],
    );
  }
}
