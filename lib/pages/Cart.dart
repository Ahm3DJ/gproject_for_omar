// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/model/User.dart';
import 'package:graduation_project2/shared/colors.dart';
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

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 76, 141, 95),
          title: Text("Cart  "),
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
                                        Text("username ${data["usernameFarmer"]} "),
                                        Column(
                                          children: [
                                            Text("price: ${data["price"]} "),
                                            Text("title: ${data["title"]} "),
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
                                              .doc(
                                                  snapshot.data!.docs[index].id)
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
                    QuerySnapshot sourceSnapshot = await FirebaseFirestore
                        .instance
                        .collection('cartSSS')
                        .where("uidStorOwner",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .get();

                    for (QueryDocumentSnapshot document
                        in sourceSnapshot.docs) {
                      // Get the data of the document
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;

                      // Create a new document in the destination collection with the same data
                      await FirebaseFirestore.instance
                          .collection('RequstedDDD')
                          .add(data);


                          await FirebaseFirestore.instance
                          .collection('cartSSS')
                          .doc(document.id)
                          .delete();
                          
                    //  l1.add(document.id);

                      // Optionally, delete the original document from the source collection
                      // await document.reference.delete();
                    }
  //                   for (int i = 0; i < l1.length; i++) {
  //                     await FirebaseFirestore.instance
  //                         .collection('cartSSS')
  //                         .doc(l1[i])
  //                         .delete();
  //                     if (i == l1.length - 1) 
  //                     {
  // Navigator.pop(context);

  //                     }
  //                   }
                  
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
