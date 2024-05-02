// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project2/pages/notifStoreOwner.dart';
import 'package:graduation_project2/shared/Timer.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:uuid/uuid.dart';

class RequsteProdact extends StatefulWidget {
  const RequsteProdact({super.key});

  @override
  State<RequsteProdact> createState() => _RequsteProdactState();
}

class _RequsteProdactState extends State<RequsteProdact> {
  bool acceptRequste = false;
  late DocumentSnapshot documentSnapshot;
  late final Stream<QuerySnapshot> _usersStream;
  @override
  void initState() {
    super.initState();
    _usersStream = FirebaseFirestore.instance
        .collection('RequstedDDD')
        .where("uidFarmer", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    //final classInstancee = Provider.of<RequsteProdact>(context);
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 76, 141, 95),
          title: Text("RequsteProdact  "),
          //  actions: [AppBarRebited()],
        ),
        body: Center(
          child: Padding(
            padding: widthScreen > 600
                ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
                : const EdgeInsets.all(0),
            child: Column(
              children: [
                Container(
                    height: 600,
                    margin: EdgeInsets.only(bottom: 20),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _usersStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return ListView.builder(
                              //      itemCount: classInstancee.selectedProdact.length,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic> data =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                return Card(
                                  child: Container(
                                      child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "${data["profileImg"]}"),
                                          // AssetImage(classInstancee
                                          //     .selectedProdact[index].pathImage),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                                "username ${data["usernameStoreOwner"]} "),
                                            Column(
                                              children: [
                                                Text(
                                                    "price: ${data["price"]} "),
                                                Text(
                                                    "title: ${data["title"]} "),
                                                Text(
                                                    "quantity: ${data["partquntity"]} "),
                                                Text(
                                                    "ProdactName: ${data["prodactName"]} "),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            data["farmerAcceptedRequest"]
                                                ? IconButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "RequstedDDD")
                                                          .doc(snapshot.data!
                                                              .docs[index].id)
                                                          .delete();
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "notifiayYYY")
                                                          .doc(documentSnapshot.get(
                                                              'storeOwnerCheckDelivery'))
                                                          .delete();

                                                      // await FirebaseFirestore.instance
                                                      // .collection("RequstedDDD")
                                                      // .doc
                                                      //////////  هاذ الكود  اكتبه قلوبل  فارر  واستدعيه
                                                      ///وغير بس القيت  و اديليت
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ))
                                                : SizedBox(),
                                            data["farmerAcceptedRequest"]
                                                ? IconButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'RequstedDDD')
                                                          .doc(snapshot.data!
                                                              .docs[index].id)
                                                          .set(
                                                              {
                                                            "farmerCheckDelivery":
                                                                true
                                                          },
                                                              SetOptions(
                                                                  merge: true));

                                                      //  await FirebaseFirestore
                                                      //     .instance
                                                      //     .collection(data[
                                                      //         "NotifiyProdactUid"])
                                                      //     .get();

                                                      documentSnapshot =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'notifiayYYY')
                                                              .doc(data[
                                                                  "NotifiyProdactUid"])
                                                              .get();

                                                      if (data[
                                                              "farmerCheckDelivery"] &&
                                                          documentSnapshot.get(
                                                              'storeOwnerCheckDelivery')) {
                                                        showSnackBar(context,
                                                            "Delevary is Done ......");
                                                      } else if (data[
                                                              "farmerCheckDelivery"] &&
                                                          documentSnapshot.get(
                                                                  'storeOwnerCheckDelivery') ==
                                                              false) {
                                                        showSnackBar(context,
                                                            "Store Owner is not check delivery ");
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    ))
                                                : SizedBox(),
                                            !data["farmerAcceptedRequest"]
                                                ? TextButton(
                                                    onPressed: () async {
                                                      // String newId =
                                                      //     const Uuid().v1();

                                                      // await FirebaseFirestore
                                                      //     .instance
                                                      //     .collection(
                                                      //         'RequstedDDD')
                                                      //     .doc(snapshot.data!
                                                      //         .docs[index].id)
                                                      //     .set(
                                                      //         {
                                                      //       "farmerRejectedRequest":
                                                      //           true,
                                                      //       "NotifiyProdactUid":
                                                      //           ""
                                                      //     },
                                                      //         SetOptions(
                                                      //             merge: true));
                                                      /////////////////////////////////////////////////////
                                                      // await FirebaseFirestore
                                                      //     .instance
                                                      //     .collection(
                                                      //         "RequstedDDD")
                                                      //     .doc(snapshot.data!
                                                      //         .docs[index].id)
                                                      //     .update({
                                                      //   "farmerAcceptedRequest":
                                                      //       true
                                                      // });
                                                      /////////////////////////////////////////////////////////////
                                                      // await FirebaseFirestore
                                                      //     .instance
                                                      //     .collection(
                                                      //         'RequstedDDD')
                                                      //     .doc(snapshot.data!
                                                      //         .docs[index].id)
                                                      //     .set(
                                                      //         {
                                                      //       "farmerRejectedRequest":
                                                      //           snapshot
                                                      //               .data!
                                                      //               .docs[index]
                                                      //               .id,
                                                      //       "NotifiyProdactUid":
                                                      //           ""
                                                      //     },
                                                      //         SetOptions(
                                                      //             merge: true));

                                                      DocumentReference docRef =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'notifiayYYY')
                                                              .add(data);

                                                      String NotifayUid =
                                                          docRef.id;

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "RequstedDDD")
                                                          .doc(snapshot.data!
                                                              .docs[index].id)
                                                          .set(
                                                              {
                                                            "NotifiyProdactUid":
                                                                NotifayUid,
                                                            "farmerRejectedRequest":
                                                                true,
                                                          },
                                                              SetOptions(
                                                                  merge: true));
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "notifiayYYY")
                                                          .doc(NotifayUid)
                                                          .set(
                                                              {
                                                            "requstedProdactUID":
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id,
                                                            "NotifiyProdactUid":
                                                                NotifayUid,
                                                            "farmerRejectedRequest":
                                                                true,
                                                          },
                                                              SetOptions(
                                                                  merge: true));

                                                      String currentQuantity =
                                                          "";

                                                      DocumentReference docRefPost =FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "postSSS") 
                                                              .doc(data[
                                                                  "postUid"]);
                                                    
                                                      DocumentSnapshot
                                                          docSnapshotPost =
                                                          await docRefPost
                                                              .get();

                                                      if (docSnapshotPost
                                                          .exists) {
                                                        // Access specific fields from the document snapshot
                                                        Map<String, dynamic>?
                                                            dataa =
                                                            docSnapshotPost
                                                                    .data()
                                                                as Map<String,
                                                                    dynamic>?;
                                                        if (dataa != null) {
                                                          dynamic specificData =
                                                              dataa['quntity'];
                                                          currentQuantity =
                                                              specificData
                                                                  .toString(); // Replace "specific_field" with the field you want to retrieve
                                                          print(
                                                              "currentQuantity: $currentQuantity");

                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "postSSS")
                                                              .doc(data[
                                                                  "postUid"])
                                                              .update({
                                                            "quntity": (int.parse(
                                                                        currentQuantity) +
                                                                    int.parse(data[
                                                                        "partquntity"]))
                                                                .toString()
                                                          });





DocumentReference docRefUser = FirebaseFirestore
                                  .instance
                                  .collection(
                                      "userSSS") // Replace "your_collection" with your actual collection name
                                  .doc(data[
                                      "uidFarmer"]);
                                        DocumentSnapshot docSnapshotUser = await docRefUser.get();
    Map<String, dynamic>? dataUSER =
                                    docSnapshotUser.data() as Map<String, dynamic>?;
  dynamic specificDataUser = dataUSER!['balance'];

                                                            await FirebaseFirestore.instance
                                        .collection('userSSS')
                                        .doc(data["uidStorOwner"])
                                        .update({"balance"  : specificDataUser + (double.parse(data["price"])* double.parse(data["partquntity"])) });
                                                        } else {
                                                          print(
                                                              'Document data is null');
                                                        }
                                                      } else {
                                                        print(
                                                            'Document does not exist');
                                                      }

                                                      // await FirebaseFirestore
                                                      //     .instance
                                                      //     .collection("postSSS")
                                                      //     .doc(data["postUid"])
                                                      //     .update({"quntity":});

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "RequstedDDD")
                                                          .doc(snapshot.data!
                                                              .docs[index].id)
                                                          .delete();
                                                      ///////////////////////////////////////////////////////////////////////////////////////////////////////////

                                                      DeleteItem(
                                                          notifiyProdactUid:
                                                              NotifayUid,
                                                          hour: 12,
                                                          seconds: 0,
                                                          requstedProdactUid:
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id);
                                                    },
                                                    child: Text('Rejected ',
                                                        style: TextStyle(
                                                            color: Colors.red)),
                                                  )
                                                : SizedBox(),
                                            !data["farmerAcceptedRequest"]
                                                ? TextButton(
                                                    onPressed: () async {
                                                      // String newId =
                                                      //     const Uuid().v1();
                                                      // await FirebaseFirestore
                                                      //     .instance
                                                      //     .collection(
                                                      //         "RequstedDDD")
                                                      //     .doc(snapshot.data!
                                                      //         .docs[index].id)
                                                      //     .update({
                                                      //   "farmerAcceptedRequest":
                                                      //       true
                                                      // });

                                                      // await FirebaseFirestore
                                                      //     .instance
                                                      //     .collection(
                                                      //         'RequstedDDD')
                                                      //     .doc(snapshot.data!
                                                      //         .docs[index].id)
                                                      //     .set(
                                                      //         {
                                                      //       "requstedProdactUID":
                                                      //           snapshot
                                                      //               .data!
                                                      //               .docs[index]
                                                      //               .id,
                                                      //       "NotifiyProdactUid":
                                                      //           ""
                                                      // //     },
                                                      //         SetOptions(
                                                      //             merge: true));

                                                      DocumentReference docRef =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'notifiayYYY')
                                                              .add(data);

                                                      String NotifayUid =
                                                          docRef.id;

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "RequstedDDD")
                                                          .doc(snapshot.data!
                                                              .docs[index].id)
                                                          .set(
                                                              {
                                                            "NotifiyProdactUid":
                                                                NotifayUid,
                                                            "requstedProdactUID":
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id,
                                                            "farmerAcceptedRequest":
                                                                true
                                                          },
                                                              SetOptions(
                                                                  merge: true));
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "notifiayYYY")
                                                          .doc(NotifayUid)
                                                          .set(
                                                              {
                                                            "requstedProdactUID":
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id,
                                                            "NotifiyProdactUid":
                                                                NotifayUid,
                                                            'farmerAcceptedRequest':
                                                                true,
                                                            'farmerRejectedRequest':
                                                                false
                                                          },
                                                              SetOptions(
                                                                  merge: true));
                                                      ///////////////////////////////////////////////////////////////////////////////////////////////////////////

                                                      DeleteItem(
                                                          notifiyProdactUid:
                                                              NotifayUid,
                                                          hour: 12,
                                                          seconds: 0,
                                                          requstedProdactUid:
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id);
                                                    },
                                                    child: Text('Accept',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blue)),
                                                  )
                                                : SizedBox(),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                                );
                              });
                        })),
                ElevatedButton(
                  onPressed: () {
                    acceptRequste = true;
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BTNgreen),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: Text(
                    "click here",
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
