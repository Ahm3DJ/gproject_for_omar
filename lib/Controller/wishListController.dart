import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:intl/intl.dart';

class WishListController {
  late Map<String, dynamic> Da = {};

  DeleteAllWishList() async {




var collectionRef = FirebaseFirestore.instance.collection("WishListTTT");
  var docs = await collectionRef.get();
  for (var doc in docs.docs) {
    await doc.reference.delete();
  }
  }

  toggleLike({
    required Map<String, dynamic> postData,
  }) async {
    FirebaseFirestore fbf = FirebaseFirestore.instance;
    String? WhislistUid;
    Da = postData;
    try {
      if (postData["likes"].contains(FirebaseAuth.instance.currentUser!.uid)) {
        await fbf.collection("postSSS").doc(postData["postId"]).update({
          "likes":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
        });

        QuerySnapshot querySnapshot = await fbf
            .collection('WishListTTT')
            .where("postId", isEqualTo: postData["postId"])
            .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();

        querySnapshot.docs.forEach((doc) async {
          await doc.reference.delete();
        });
      } else {
        await fbf.collection("postSSS").doc(postData["postId"]).update({
          "likes":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });

        // await FirebaseFirestore.instance
        //     .collection('WishListTTT')
        //     .add(postData);

        DocumentReference docRef =
            await fbf.collection('WishListTTT').add(postData);
        WhislistUid = docRef.id;
        await fbf.collection('WishListTTT').doc(WhislistUid).set({
          "WhislistUid": WhislistUid,
          "UidClickWish": FirebaseAuth.instance.currentUser!.uid
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget StreamBuilderWishList(BuildContext context,
      {required collectionn, required uid}) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamWishList(uid: uid, collectionn: collectionn),
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

        return ListWidgetCart(snapshot.data!);
      },
    );
  }

  Stream<QuerySnapshot> streamWishList({required collectionn, required uid}) {
    late final Stream<QuerySnapshot> _usersStream;
    _usersStream = FirebaseFirestore.instance
        .collection('WishListTTT')
        .where("UidClickWish",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return _usersStream;
  }

  Widget ListWidgetCart(QuerySnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (BuildContext context, int index) {
        DocumentSnapshot document = snapshot.docs[index];
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return Card(
          child: Container(
              child: SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("${data["imgPost"]}"),
                  // AssetImage(classInstancee
                  //     .selectedProdact[index].pathImage),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("username ${data["username"]} "),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("price: ${data["price"]} "),
                        Text("title: ${data["title"]} "),
                        Text("ProdactName: ${data["prodactName"]} "),
                        Text(
                            "Date of Publish:  ${data["datePublished"] == null ? data["datePublished"] : DateFormat('MMMM d, ' 'y').format(data["datePublished"].toDate())} ")
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("WishListTTT")
                          .doc(snapshot.docs[index].id)
                          .delete();

                      toggleLike(postData: Da);
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.red,
                      size: 30,
                    ))
              ],
            ),
          )),
        );
      },
    );
  }
}
