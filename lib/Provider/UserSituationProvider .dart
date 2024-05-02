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



String? getUserSituation() {
  try {
    // Get the current user's UID
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the document of the current user
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('userSSS')
        .doc(currentUserUid);

    // Fetch the document snapshot synchronously (blocking call)
    DocumentSnapshot userDocSnapshot = userDocRef.get() as DocumentSnapshot<Object?>;

    if (userDocSnapshot.exists) {
      // Access the 'situation' field from the document data
      Map<String, dynamic>? userData = userDocSnapshot.data() as Map<String, dynamic>?;
      String? situation = userData?['situation'];
      return situation ; // Return the situation string or an empty string if it's null
    } else {
      // Document does not exist
      print('User document does not exist');
      return ''; // Return an empty string
    }
  } catch (error) {
    // Error handling
    print('Error getting user situation: $error');
    return ''; // Return an empty string
  }
}




  
}