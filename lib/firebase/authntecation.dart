import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project2/firebase/Storage.dart';
import 'package:graduation_project2/model/User.dart';
import 'package:graduation_project2/model/cart.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class AuthMethods {
  register({
    required emailll,
    required passworddd,
    required context,
    required titleee,
    required usernameee,
    required imgName,
    required imgPath,
    required age,
    required situation,
    required balance,
        required phoneNumber,
  }) async {
    String message = "ERROR => Not starting the code";

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailll,
        password: passworddd,
      );

      message = "ERROR => Registered only";

// ______________________________________________________________________

      String urlll = await getImgURL(
        imgName: imgName,
        imgPath: imgPath,
        folderName: 'profileIMG',
      ); // save Imag in FIREStorage and get link image
      message = "ERROR => upload imag e ";
// _______________________________________________________________________
// firebase firestore (Database)
      CollectionReference users =
          FirebaseFirestore.instance.collection('userSSS');

      UserDete userr = UserDete(
        email: emailll,
        password: passworddd,
        title: titleee,
        username: usernameee,
        profileImg: urlll,
        uid: credential.user!.uid,
        age: age,
        situation: situation,
        balance: balance, phoneNumber: phoneNumber,
      );
      message = "ERROR => create object user  ";

      users
          .doc(credential.user!.uid)
          .set(userr.convert2Map())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      message = " Registered & User Added 2 DB ♥";
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    } catch (e) {
      print(e);
    }

    showSnackBar(context, message);
  }

  signIn({required emailll, required passworddd, required context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailll, password: passworddd);

      print("ssssssssssssssssssssssssssssssss");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    } catch (e) {
      showSnackBar(context, "email and password are  wrong ");
    }
  }

  // required this.title,
  //   required this.username,
  //   required this.profileImg,
  //   required this.uid,
  //   required this.situation,
  //   required this.prodactName,
  //   required this.imgPost,
  //   required this.partquntity,

  SendDataToPageRequst({
    required context,
    required titleee,
    required usernameee,
    required profileImg,
    required uidFarmer,
    required uidStorOwner,
    required prodactName,
    required imgPost,
    required partquntity,
    required price,
    required storeOwnerCheckDelivery,
    required usernameFarmer,
    required usernameStoreOwner,
    required farmerAcceptedRequest,
    required farmerCheckDelivery,
    required postUid,
      required phoneNumber,
  }) async {
    String message = "ERROR => Not starting the code";
    print("111111111 1storeOwnerSendRequst11111111111111${context}");
    print("22222222storeOwnerSendRequst22222222222222222222${titleee}");
    print("33333333storeOwnerSendRequst33333${usernameee}");

    print("44444444storeOwnerSendRequst4444444444${profileImg}");

    print("555555storeOwnerSendRequst555555555${uidFarmer}");
    print("555555storeOwnerSendRequst555555555${uidStorOwner}");
    print("66666storeOwnerSendRequst66666666${prodactName}");

    print("8888888storeOwnerSendRequst8888888888888888${imgPost}");
    print("99999999storeOwnerSendRequst99999999999999${partquntity}");

    try {
      message = "ERROR => Registered only";

// ______________________________________________________________________

// _______________________________________________________________________
// firebase firestore (Database)
      message = " 1 Before Created Object   storeOwnerSendRequst ";
      CollectionReference carts =
          FirebaseFirestore.instance.collection('RequstedData');
      message = " 2 Before Created Object  storeOwnerSendRequst";
      ProdactCartAllUser userr = ProdactCartAllUser(
        title: titleee,

        profileImg: profileImg,
        uidFarmer: uidFarmer,
        prodactName: prodactName,
        partquntity: partquntity,
        imgPost: imgPost,
        price: price,
        uidStorOwner: uidStorOwner,
        storeOwnerCheckDelivery: storeOwnerCheckDelivery,
        usernameFarmer: usernameFarmer,
        usernameStoreOwner: usernameStoreOwner,
        farmerAcceptedRequest: farmerAcceptedRequest,
        farmerCheckDelivery: farmerCheckDelivery, postUid: postUid, phoneNumber:phoneNumber ,

        // String title;
        // String username;
        // String profileImg;
        // String uid;
        // String situation;
        // String prodactName;
        // String partquntity;
        // String imgPost;
      );
      message = " after  Created Object storeOwnerSendRequst ";

      String newId = const Uuid().v1();
      carts
          .doc(newId)
          .set(userr.convert2Map())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      message = " Add Prodact to Cart  DB ♥  storeOwnerSendRequst";
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    } catch (e) {
      print(e);
    }

    showSnackBar(context, message);
  }

  AddProdactToUserCart({
    required context,
    required titleee,
    required profileImg,
    required uidFarmer,
    required uidStorOwner,
    required prodactName,
    required imgPost,
    required partquntity,
    required price,
    required storeOwnerCheckDelivery,
    required farmerCheckDelivery,
    required farmerAcceptedRequest,
    required usernameStoreOwner,
    required usernameFarmer,
    required postUid,
    required phoneNumber,
  }) async {
    String message = "ERROR => Not starting the code";
    print("111111111111111111111111${context}");
    print("2222222222222222222222222222${titleee}");

    print("444444444444444444${profileImg}");

    print("555555555555555${uidFarmer}");
    print("555555555555555${uidStorOwner}");
    print("6666666666666${prodactName}");

    print("88888888888888888888888${imgPost}");
    print("9999999999999999999999${partquntity}");

    try {
      message = "ERROR => Registered only";

// ______________________________________________________________________

// _______________________________________________________________________
// firebase firestore (Database)
      message = " 1 Before Created Object ";
      CollectionReference carts =
          FirebaseFirestore.instance.collection('cartSSS');
      message = " 2 Before Created Object ";
      ProdactCartAllUser userr = ProdactCartAllUser(
        title: titleee,

        profileImg: profileImg,
        uidFarmer: uidFarmer,
        prodactName: prodactName,
        partquntity: partquntity,
        imgPost: imgPost,
        price: price,
        uidStorOwner: uidStorOwner,
        storeOwnerCheckDelivery: storeOwnerCheckDelivery,
        usernameFarmer: usernameFarmer, usernameStoreOwner: usernameStoreOwner,
        farmerAcceptedRequest: farmerAcceptedRequest,
        farmerCheckDelivery: farmerCheckDelivery, postUid: postUid, phoneNumber:phoneNumber ,

        // String title;
        // String username;
        // String profileImg;
        // String uid;
        // String situation;
        // String prodactName;
        // String partquntity;
        // String imgPost;
      );
      message = " after  Created Object ";

      String newId = const Uuid().v1();
      carts
          .doc(newId)
          .set(userr.convert2Map())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      message = " Add Prodact to Cart  DB ♥";
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    } catch (e) {
      print(e);
    }

    showSnackBar(context, message);
  }

  editeProfilePage({
    required imgName,
    required imgPath,
  }) async {
      String urlll = await getImgURL(
        imgName: imgName,
        imgPath: imgPath,
        folderName: 'profileIMG',
      );

    FirebaseFirestore.instance
        .collection('userSSS')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"profileImg": urlll});

    // FirebaseFirestore.instance
    //     .collection('postSSS')
    //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .get()
    //     .then();

    CollectionReference postsCollection =
        FirebaseFirestore.instance.collection('postSSS');

    // Query documents where a specific field has a certain value
    QuerySnapshot querySnapshot = await postsCollection
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    // Loop through each document
    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      // Update the 'profileImg' field in each document
      await docSnapshot.reference.update({'profileImg': urlll});
    }

//  CollectionReference postsCollection =
//         FirebaseFirestore.instance.collection('postSSS');

//     // Get all documents from the collection
//     QuerySnapshot querySnapshot = await postsCollection.get();

//     // Loop through each document
//     for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
//       // Update the 'profileImg' field in each document
//       await docSnapshot.reference.update({'profileImg': urlll});
//     }
    //   FirebaseFirestore.instance
    // .collection('postSSS')
    // .doc(FirebaseAuth.instance.currentUser!.uid)
    // .update({"profileImg":urlll});
  }
}
