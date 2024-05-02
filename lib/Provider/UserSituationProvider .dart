import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSituationProvider with ChangeNotifier {
  String? _userSituation;

  String? get userSituation => _userSituation;

  // Function to fetch user situation data from Firestore
  Future<void> fetchUserSituation() async {
    // Fetch user situation from Firestore
    String? situation = await getUserSituation();

    // Update the state with the fetched data
    _userSituation = situation;

    // Notify listeners of the change in state
    notifyListeners();
  }




Future<String?> getUserSituation() async {
  try {
    // Get the current user's UID
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the document of the current user
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('userSSS')
        .doc(currentUserUid);

    // Fetch the document snapshot
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    if (userDocSnapshot.exists) {
      // Access the 'situation' field from the document data
      Map<String, dynamic>? userData = userDocSnapshot.data() as Map<String, dynamic>?;
      String? situation = userData?['situation'];
      return situation;
    } else {
      // Document does not exist
      print('User document does not exist');
      return null;
    }
  } catch (error) {
    // Error handling
    print('Error getting user situation: $error');
    return null;
  }
}




  
}