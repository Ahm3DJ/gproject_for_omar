
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:graduation_project2/Controller/RequstedProdactController.dart';


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
    _usersStream = RequstedProdactConrtoller()
        .streamRequsted(collectionn: "RequstedDDD", uid: "uidFarmer");
  }

  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    //final classInstancee = Provider.of<RequsteProdact>(context);
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 76, 141, 95),
          title: const Text("RequsteProdact  "),
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
                    margin: const EdgeInsets.only(bottom: 20),
                child:RequstedProdactConrtoller(). StreamBuilderRequsted(context, collectionn: "RequstedDDD", uid: "uidFarmer")
          
              ),
               ],
            ),
     ),
        ));
  }
}
