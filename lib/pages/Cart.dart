// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/model/User.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late final Stream<QuerySnapshot> _usersStream;
  @override
  void initState() {
    super.initState();
    _usersStream = FirebaseFirestore.instance
        .collection('cartSSS')
        .where("uidStorOwner",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);
    //userProvider.refreshUser();
    UserDete? userData = userProvider.getUser;
    String cartDoc = "";
    List l1 = [];

    //final classInstancee = Provider.of<Cart>(context);
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 76, 141, 95),
          title: Text("Cart  "),
          //  actions: [AppBarRebited()],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: widthScreen > 600
                      ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
                      : const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Container(
                        height: heightScreen - 250,
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Map<String, dynamic> data =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;
                                    cartDoc = snapshot.data!.docs[index].id;
                                    return Card(
                                      child: Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(data["imgPost"]),
                                            // AssetImage(classInstancee
                                            //     .selectedProdact[index].pathImage),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                  "username ${data["usernameFarmer"]} "),
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
                                          IconButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection("cartSSS")
                                                    .doc(snapshot
                                                        .data!.docs[index].id)
                                                    .delete();
                                                // classInstancee.sum -=
                                                //     classInstancee.selectedProdact[index].price;

                                                // classInstancee.removeAtIndex(index);
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                color: Colors.red,
                                                size: 30,
                                              ))
                                        ],
                                      )),

                                      // child: ListTile(
                                      //   subtitle: Text(
                                      //       //            "\$${classInstancee.selectedProdact[index].price}  -  ${classInstancee.selectedProdact[index].location}"
                                      //       ""),
                                      //   leading: CircleAvatar(
                                      //     backgroundImage:
                                      //     NetworkImage(data["imgPost"]),
                                      //     // AssetImage(classInstancee
                                      //     //     .selectedProdact[index].pathImage),
                                      //   ),
                                      //   title: Text(
                                      //       // classInstancee.selectedProdact[index].flowerName
                                      //     data["prodactName"]),
                                      //   trailing: IconButton(
                                      //       onPressed: () {
                                      //         // classInstancee.sum -=
                                      //         //     classInstancee.selectedProdact[index].price;

                                      //         // classInstancee.removeAtIndex(index);
                                      //       },
                                      //       icon: Icon(Icons.remove)),
                                      // ),
                                    );
                                  });
                            }),
                      ),
                      ElevatedButton(
                        onPressed: () async {
////////////////////////////////////get data ffrom cart in fire base and send it to  requsted prodact to firebase and delete item from cart in fire base

                          QuerySnapshot sourceSnapshot = await FirebaseFirestore
                              .instance
                              .collection('cartSSS')
                              .where("uidStorOwner",
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .get();

                          for (QueryDocumentSnapshot document
                              in sourceSnapshot.docs) {
                            // Get the data of the document
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;

                            // Create a new document in the destination collection with the same data
                            // await FirebaseFirestore.instance
                            //     .collection('RequstedDDD')
                            //     .add(data);

                            // await FirebaseFirestore.instance
                            //     .collection('cartSSS')
                            //     .doc(document.id)
                            //     .delete();

                            String currentQuantity = "";

                            try {

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
                              // Reference to the document you want to retrieve data from
                              DocumentReference docRef = FirebaseFirestore
                                  .instance
                                  .collection(
                                      "postSSS") // Replace "your_collection" with your actual collection name
                                  .doc(data[
                                      "postUid"]); // Replace "your_document_id" with your actual document ID
                              print("postUid  Data: ${data["postUid"]}");

                              // Fetch the document snapshot
                              DocumentSnapshot docSnapshot = await docRef.get();

                              if (docSnapshot.exists) {
                                // Access specific fields from the document snapshot
                                Map<String, dynamic>? dataa =
                                    docSnapshot.data() as Map<String, dynamic>?;
                                if (dataa != null) {
                                  dynamic specificData = dataa['quntity'];
                                  currentQuantity = specificData
                                      .toString(); // Replace "specific_field" with the field you want to retrieve
                                  print("currentQuantity: $currentQuantity");

                                  if (int.parse(currentQuantity) == 0) {
                                    showSnackBar(context,
                                        "The product  ${data["prodactName"]} is sold");
                                  } else if (int.parse(currentQuantity) <
                                      int.parse(data["partquntity"])) {
                                    showSnackBar(context,
                                        "Please reorder the product From Home page ${data["prodactName"]}");
                                  } else if (int.parse(currentQuantity) == 0 ||
                                      int.parse(currentQuantity) <
                                          int.parse(data["partquntity"])) {
                                    await FirebaseFirestore.instance
                                        .collection('cartSSS')
                                        .doc(document.id)
                                        .delete();
                                  } else {
                                    int newQuantity =
                                        int.parse(currentQuantity) -
                                            int.parse(data["partquntity"]);

                                    await FirebaseFirestore.instance
                                        .collection("postSSS")
                                        .doc(data["postUid"])
                                        .update({
                                      "quntity": newQuantity.toString()
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('userSSS')
                                        .doc(data["uidStorOwner"])
                                        .update({"balance"  : specificDataUser - (double.parse(data["price"])* double.parse(data["partquntity"])) });
                                  }
                                } else {
                                  print('Document data is null');
                                }
                              } else {
                                print('Document does not exist');
                              }
                            } catch (error) {
                              print('Error fetching data: $error');
                            }

                            // Create a new document in the destination collection with the same data
                            await FirebaseFirestore.instance
                                .collection('RequstedDDD')
                                .add(data);

                            await FirebaseFirestore.instance
                                .collection('cartSSS')
                                .doc(document.id)
                                .delete();
                          }
                          //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///

                          ///
                          // try {
                          //   // Reference to the document you want to retrieve data from
                          //   DocumentReference docRef = FirebaseFirestore
                          //       .instance
                          //       .collection(
                          //           "postSSS") // Replace "your_collection" with your actual collection name
                          //       .doc(data[
                          //           "postUid"]); // Replace "your_document_id" with your actual document ID

                          //   // Fetch the document snapshot
                          //   DocumentSnapshot docSnapshot = await docRef.get();

                          //   if (docSnapshot.exists) {
                          //     // Access specific fields from the document snapshot
                          //     Map<String, dynamic>? dataa =
                          //         docSnapshot.data() as Map<String, dynamic>?;
                          //     if (dataa != null) {
                          //       dynamic specificData = dataa['quntity'];
                          //       currentQuantity = specificData
                          //           .toString(); // Replace "specific_field" with the field you want to retrieve
                          //       print("Specific Data: $specificData");
                          //       print("currentQuantity: $currentQuantity");
                          //     } else {
                          //       print('Document data is null');
                          //     }
                          //   } else {
                          //     print('Document does not exist');
                          //   }
                          // } catch (error) {
                          //   print('Error fetching data: $error');
                          // }

                          //                             DocumentSnapshot postRef =
                          // FirebaseFirestore.instance.collection("postSSS").
                          // doc(data["postUid"]).get() as DocumentSnapshot<Object?>;
                          //  String currentQuantity2 =postRef.data()!["quntity"];
                          // int newQuantity = int.parse(currentQuantity) -
                          //     int.parse(data["quntity"]);
                          // print("]]]]]]]]]]]]]]]]]]]]]]]]]]${data["quntity"]}");

                          // print("]]]]]]]]]]]]]]]]]]]]]]]]]]$currentQuantity");

                          // print("]]]]]]]]]]]]]]]]]]]]]]]]]]$newQuantity");

                          // await FirebaseFirestore.instance
                          //     .collection("postSSS")
                          //     .doc(data["postUid"])
                          //     .update({"quntity": newQuantity.toString()});

                          //
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(BTNgreen),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(12)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
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
              ),
            ],
          ),
        ));
  }
}
