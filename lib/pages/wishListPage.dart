// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project2/Controller/CartController.dart';
import 'package:graduation_project2/Controller/RequstedProdactController.dart';
import 'package:graduation_project2/Controller/ResponsiveController.dart';
import 'package:graduation_project2/Controller/wishListController.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  bool acceptRequste = false;
  late DocumentSnapshot documentSnapshot;
  late final Stream<QuerySnapshot> _usersStream;
  @override
  void initState() {
    super.initState();
    _usersStream = WishListController()
        .streamWishList(collectionn: "RequstedDDD", uid: "uidFarmer");
  }

  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    //final classInstancee = Provider.of<WishList>(context);
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 76, 141, 95),
          title: Text("WishList  "),
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
                    height: 550,
                    margin: EdgeInsets.only(bottom: 20),
                    child: WishListController().StreamBuilderWishList(context,
                        collectionn: "RequstedDDD", uid: "uidFarmer")),
                ElevatedButton(
                  onPressed: () async {
                    WishListController().DeleteAllWishList();
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
