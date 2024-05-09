// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';

class ViewProfilePictures {

static   int  count=0;
   getCounterPost() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('postSSS')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    // Get the count of documents that match the condition
     count = querySnapshot.docs.length;
    return count;
  }

  Widget GridWidgetPictureFarmer(QuerySnapshot snapshot) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: snapshot.docs.length,
      itemBuilder: (BuildContext context, int index) {
          count = snapshot.docs.length;
        DocumentSnapshot document = snapshot.docs[index];
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            data["imgPost"],
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget StreamBuilderPictureFarmer(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('postSSS')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return showSnackBar(context, "Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        return GridWidgetPictureFarmer(snapshot.data!);
      },
    );
  }
}
