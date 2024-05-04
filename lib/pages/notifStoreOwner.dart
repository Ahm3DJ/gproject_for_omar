// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/Notifecation.dart';
import 'package:graduation_project2/shared/Timer.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NotifayStoreOwner extends StatefulWidget {
  @override
  State<NotifayStoreOwner> createState() => _NotifayStoreOwnerState();
}

class _NotifayStoreOwnerState extends State<NotifayStoreOwner> {
  late final Stream<QuerySnapshot> _usersStream;
  @override
  void initState() {
    super.initState();
    _usersStream = FirebaseFirestore.instance
        .collection('notifiayYYY')
        .where("uidStorOwner",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    //final classInstancee = Provider.of<NotifayStoreOwner>(context);
    final double widthScreen = MediaQuery.of(context).size.width;
    final classInstancee = Provider.of<Notificationn>(context);
    int c = 0;
    late DocumentSnapshot documentSnapshot;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 76, 141, 95),
          title: Text("NotifayStoreOwner  "),
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
                                // classInstancee.count =
                                //     snapshot.data!.docs.length;
                                // classInstancee.l1 = data;

                                return Card(
                                  child: Container(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage("${data["imgPost"]}"),
                                        // AssetImage(classInstancee
                                        //     .selectedProdact[index].pathImage),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "username ${data["usernameStoreOwner"]} "),
                                          Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,

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
                                      !data["farmerRejectedRequest"]
                                          ? Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    final Uri phoneNumber =
                                                        Uri.parse(
                                                            "tel:0775218832");
                                                    final Uri whatsApp = Uri.parse(
                                                        "https://wa.me/+962${data["phoneNumber"]}");
                                                    launchUrl(whatsApp);
                                                  },
                                                  child: SvgPicture.asset(
                                                      "assets/icons8-whatsapp.svg"),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'notifiayYYY')
                                                          .doc(snapshot.data!
                                                              .docs[index].id)
                                                          .update({
                                                        "storeOwnerCheckDelivery":
                                                            true
                                                      });

                                                      //  await FirebaseFirestore
                                                      //     .instance
                                                      //     .collection(data[
                                                      //         "NotifiyProdactUid"])
                                                      //     .get();

                                                      documentSnapshot =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'RequstedDDD')
                                                              .doc(data[
                                                                  "requstedProdactUID"])
                                                              .get();

                                                      if (data[
                                                              "storeOwnerCheckDelivery"] &&
                                                          documentSnapshot.get(
                                                              'farmerCheckDelivery')) {
                                                        showSnackBar(context,
                                                            "Delevdeliveryary is Done ......");

                                                        DeleteItem(
                                                            notifiyProdactUid:
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id,
                                                            requstedProdactUid:
                                                                data[
                                                                    "requstedProdactUID"],
                                                            seconds: 1);
                                                      } else if (data[
                                                              "storeOwnerCheckDelivery"] &&
                                                          documentSnapshot.get(
                                                                  'farmerCheckDelivery') ==
                                                              false) {
                                                        showSnackBar(context,
                                                            "Farmer  is not check delivery ");
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    )),
                                              ],
                                            )
                                          : TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('notifiayYYY')
                                                    .doc(snapshot
                                                        .data!.docs[index].id)
                                                    .delete();
                                                // classInstancee.count--;
                                              },
                                              child: Text(
                                                "Rejcted",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                    ],
                                  )),
                                );
                              });
                        })),
                ElevatedButton(
                  onPressed: () {},
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
