// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project2/firebase/authntecation.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:path/path.dart' show basename;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditeProfiePage extends StatefulWidget {
  
  @override
  State<EditeProfiePage> createState() => _EditeProfiePageState();
}

class _EditeProfiePageState extends State<EditeProfiePage> {
  final credential = FirebaseAuth.instance.currentUser;
  Uint8List? imgPath;
  String? imgName;

  uploadImage() async {
    final XFile? pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(10000);
          imgName = "$random$imgName";
        });
      } else {
        showSnackBar(context, "NO img selected");
      }
    } catch (e) {
      showSnackBar(context, "Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              // await FirebaseAuth.instance.signOut();
              // if (!mounted) return;
              // Navigator.pop(context);
            },
            label: Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: appbarGreen,
        title: Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110)),
                child: Stack(
                  children: [
                    imgPath == null
                        ? CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 225, 225, 225),
                            radius: 71,
                            // backgroundImage: AssetImage("assets/img/avatar.png"),
                            backgroundImage:
                                AssetImage("assets/avatarImage.jpg"),
                          )
                        // GetImagFromFireBase()
                        : CircleAvatar(
                            radius: 71,
                            // backgroundImage: AssetImage("assets/img/avatar.png"),
                            backgroundImage: MemoryImage(imgPath!),
                          ),
                    Positioned(
                        right: -8,
                        bottom: -15,
                        child: IconButton(
                            onPressed: () async {
                              await uploadImage();

                              AuthMethods().editeProfilePage(
                                  imgName: imgName, imgPath: imgPath);
                            },
                            icon: Icon(Icons.add_a_photo)))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 131, 177, 255),
                    borderRadius: BorderRadius.circular(11)),
                child: Text(
                  "Info from firebase Auth: ",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 11,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: BTNgreen,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email:   ${credential!.email}    ",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: BTNgreen,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Created date:  ${DateFormat('yMMMMd').format(credential!.metadata.creationTime!)}    ",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: BTNgreen,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last Signed In: ${DateFormat("yMMMMd").format(credential!.metadata.lastSignInTime!)} ",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {
                            credential!.delete();
                            // users.doc(credential!.uid).delete();
                            Navigator.pop(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Login(),
                            //     ));
                          },
                          child: Text(
                            "Delete User ",
                            style: TextStyle(color: Colors.blue, fontSize: 22),
                          )))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(11),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 131, 177, 255),
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        "Info from firebase firestore :",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ))),
              // GetDataFromFireBase(
              //   documentId: credential!.uid,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
