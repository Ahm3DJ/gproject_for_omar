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
  String postUid;
  String phoneNumber;

  //anonymous names constructor, for testing purposes @AhmedGhazi
  ProdactCartAllUser.anonymous()
      : title = 'empty',
        usernameFarmer = 'empty',
        usernameStoreOwner = 'empty',
        profileImg = 'empty',
        uidFarmer = 'empty',
        uidStorOwner = 'empty',
        prodactName = 'empty',
        partquntity = 'empty',
        imgPost = 'empty',
        price = 'empty',
        storeOwnerCheckDelivery = false,
        farmerCheckDelivery = false,
        farmerAcceptedRequest = false,
        postUid = 'empty',
        phoneNumber = 'empty';

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
    required this.postUid,
    required this.phoneNumber,
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
      "postUid": postUid,
      "phoneNumber": phoneNumber,
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
      farmerAcceptedRequest: snapshot["farmerAcceptedRequest"],
      farmerCheckDelivery: snapshot["farmerCheckDelivery"],
      postUid: snapshot["postUid"],
      phoneNumber: snapshot["phoneNumber"],
    );
  }

  void set Title(String title) {
    if (title.contains(RegExp(r'([a-zA-Z]+)$'))) {
      this.title = title;
    } else {
      print('Wrong Input');
    }
  }

  void set UsernameFarmer(String usernameFarmer) {
    if (usernameFarmer.contains(RegExp(r'/^[a-zA-Z]+$/.'))) {
      this.usernameFarmer = usernameFarmer;
    } else {
      print('Wrong Input');
    }
  }

  void set UsernameStoreOwner(String usernameStoreOwner) {
    if (usernameStoreOwner.contains(RegExp(r'/^[a-zA-Z]+$/.'))) {
      this.usernameStoreOwner = usernameStoreOwner;
    } else {
      print('Wrong Input');
    }
  }

  void set ProfileImg(String profileImg) {
    if (profileImg.contains(RegExp(r'([a-zA-Z0-9#$%^\/\\*#@!-]+)$'))) {
      this.profileImg = profileImg;
    } else {
      print('Wrong Input');
    }
  }

  void set UidFarmer(String uidFarmer) {
    if (uidFarmer.contains(RegExp(r'([a-zA-Z0-9#$%^\/\\*#@!-]+)$'))) {
      this.uidFarmer = uidFarmer;
    } else {
      print('Wrong Input');
    }
  }

  void set UidStorOwner(String uidStorOwner) {
    if (uidStorOwner.contains(RegExp(r'([a-zA-Z0-9#$%^\/\\*#@!-]+)$'))) {
      this.uidStorOwner = uidStorOwner;
    } else {
      print('Wrong Input');
    }
  }

  void set ProdactName(String prodactName) {
    if (prodactName.contains(RegExp(r'/^[a-zA-Z]+$/.'))) {
      this.prodactName = prodactName;
    } else {
      print('Wrong Input');
    }
  }

  void set PhoneNumber(String phoneNumber) {
    if (phoneNumber.contains(RegExp(r'^07[789]{1}[0-9]{7}$'))) {
      this.phoneNumber = phoneNumber;
    } else {
      print('Wrong Input');
    }
  }

  //String prodactName;
}
