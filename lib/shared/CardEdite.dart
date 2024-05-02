import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/shared/colors.dart';

class CardEdite extends StatefulWidget {
  String texttitle;
  String textFireBase;
  TextEditingController newController;
  CardEdite(
      {required this.textFireBase,
      required this.texttitle,
      required this.newController});
  @override
  State<CardEdite> createState() => _CardEditeState();
}

class _CardEditeState extends State<CardEdite> {
  myShowDialog(key, value,
      {TextInputType keyboardType = TextInputType.emailAddress}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 150,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    keyboardType: keyboardType,
                    controller: value,
                    maxLength: 50,
                    decoration: InputDecoration(
                      hintText: "Add new $key  :",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('userSSS')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({key: value.text});
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Edit", style: TextStyle(fontSize: 22)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancle", style: TextStyle(fontSize: 22)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 10,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: BTNgreen,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.texttitle}:  ",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            IconButton(
                // onPressed: () {
                //   myShowDialog(data, "age", newAgeController,keyboardType: TextInputType.number);
                // },
                onPressed: () {
                  myShowDialog("${widget.textFireBase}", widget.newController
                      // keyboardType: TextInputType.number
                      );
                },
                icon: Icon(
                  Icons.edit,
                  size: 26,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
