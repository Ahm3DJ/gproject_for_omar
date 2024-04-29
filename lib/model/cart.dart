import 'package:cloud_firestore/cloud_firestore.dart';

class ProdactCartAllUser {
  String title;
  String usernameFarmer;
  String usernameStoreOwner;

  String profileImg;
  String uidFarmer;
  String uidStorOwner;

  String prodactName;
  String partquntity;
  String imgPost;
  String price;
   bool storeOwnerCheckDelivery;
   bool farmerCheckDelivery;
   bool farmerAcceptedRequest;


  ProdactCartAllUser({
    required this.title,
    required this.usernameFarmer,
    required this.usernameStoreOwner,
    required this.profileImg,
    required this.uidFarmer,
    required this.prodactName,
    required this.imgPost,
    required this.partquntity,
    required this.price,
    required this.uidStorOwner,
    required this.storeOwnerCheckDelivery,
        required this.farmerCheckDelivery,
    required this.farmerAcceptedRequest,
  });

  Map<String, dynamic> convert2Map() {
    return {
      "title": title,
      "usernameFarmer": usernameFarmer,
      "usernameStoreOwner": usernameStoreOwner,
      "profileImg": profileImg,
      "uidFarmer": uidFarmer,
      "partquntity": partquntity,
      "imgPost": imgPost,
      "prodactName": prodactName,
      "price": price,
      "uidStorOwner": uidStorOwner,
      "storeOwnerCheckDelivery": storeOwnerCheckDelivery,
      "farmerAcceptedRequest": farmerAcceptedRequest,
          "farmerCheckDelivery": farmerCheckDelivery,
    };
  }

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ProdactCartAllUser(
      title: snapshot["title"],
      profileImg: snapshot["profileImg"],
      uidFarmer: snapshot["uidFarmer"],
      prodactName: snapshot["prodactName"],
      imgPost: snapshot["prodactName"],
      partquntity: snapshot["prodactName"],
      price: snapshot["price"],
      uidStorOwner: snapshot["uidStorOwner"],
      storeOwnerCheckDelivery: snapshot["storeOwnerCheckDelivery"],
      usernameFarmer: snapshot["usernameFarmer"],
      usernameStoreOwner: snapshot["usernameStoreOwner"],
      farmerAcceptedRequest: snapshot["farmerAcceptedRequest"], farmerCheckDelivery: snapshot["farmerCheckDelivery"],
    );
  }
}
