
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class RequstedProvider with ChangeNotifier {
int count=0 ;
  // double sum = 0;
  // List<Cart> selectedProdact = [];
  // Map<String, dynamic> l1 = {};
  int getCountREQ()
   {
      FirebaseFirestore.instance
        .collection('RequstedDDD')
        .where("uidFarmer",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      count = snapshot.docs.length;

    });
  
    return count;
  }


}
