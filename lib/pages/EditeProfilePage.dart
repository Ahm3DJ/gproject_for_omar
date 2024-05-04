// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/firebase/authntecation.dart';
import 'package:graduation_project2/model/User.dart';
import 'package:graduation_project2/shared/CardEdite.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:path/path.dart' show basename;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditeProfiePage extends StatefulWidget {
  @override
  State<EditeProfiePage> createState() => _EditeProfiePageState();
}

class _EditeProfiePageState extends State<EditeProfiePage> {
  final credential = FirebaseAuth.instance.currentUser;
  Uint8List? imgPath;
  String? imgName;

  final newUserNameController = TextEditingController();
  final newAgeController = TextEditingController();
  final newTitleController = TextEditingController();
  final newPasswordController = TextEditingController();

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
                                .doc(credential!.uid)
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
    UserProvider userProvider = Provider.of(context, listen: false);
    UserDete? userData = userProvider.getUser;
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
                            backgroundImage:
                              NetworkImage(userData!.profileImg),
                          )
                        : CircleAvatar(
                            radius: 71,
                            backgroundImage: MemoryImage(imgPath!),
                          ),
                    Positioned(
                        right: -8,
                        bottom: -15,
                        child: IconButton(
                            onPressed: () async {
                              await uploadImage();
                              if (imgPath != null) {
                                AuthMethods().editeProfilePage(
                                    imgName: imgName, imgPath: imgPath);
                                // userProvider.refreshUser();
                              }
                            },
                            icon: Icon(Icons.add_a_photo)))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardEdite(
                      textFireBase: "username",
                      texttitle: "User Name   ",
                      newController: newUserNameController),
                  // Card(
                  //   shadowColor: Colors.black,
                  //   elevation: 10,
                  //   margin: EdgeInsets.all(10),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  //   color: BTNgreen,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           "User Name :  ",
                  //           style: TextStyle(fontSize: 20, color: Colors.white),
                  //         ),
                  //         IconButton(
                  //             onPressed: () {
                  //               myShowDialog( "username",
                  //                   newUserNameController);
                  //             },
                  //             icon: Icon(
                  //               Icons.edit,
                  //               size: 26,
                  //               color: Colors.white,
                  //             )),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  CardEdite(
                      textFireBase: "age",
                      texttitle: "Age",
                      newController: newAgeController),
                  //     Card(
                  //   shadowColor: Colors.black,
                  //   elevation: 10,
                  //   margin: EdgeInsets.all(10),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  //   color: BTNgreen,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           "Age:  ",
                  //           style: TextStyle(fontSize: 20, color: Colors.white),
                  //         ),
                  //         IconButton(
                  //             // onPressed: () {
                  //             //   myShowDialog(data, "age", newAgeController,keyboardType: TextInputType.number);
                  //             // },
                  //             onPressed: () {
                  //               myShowDialog("age", newAgeController,
                  //                   keyboardType: TextInputType.number);
                  //             },
                  //             icon: Icon(
                  //               Icons.edit,
                  //               size: 26,
                  //               color: Colors.white,
                  //             )),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  CardEdite(
                      textFireBase: "title",
                      texttitle: "Title",
                      newController: newTitleController),
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
                            "Title:  ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                myShowDialog("title", newTitleController);
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 26,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                  CardEdite(
                      textFireBase: "password",
                      texttitle: "Password",
                      newController: newPasswordController),
                  //   Card(
                  //   shadowColor: Colors.black,
                  //   elevation: 10,
                  //   margin: EdgeInsets.all(10),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  //   color: BTNgreen,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           "Password:  ",
                  //           style: TextStyle(fontSize: 20, color: Colors.white),
                  //         ),
                  //         IconButton(
                  //             onPressed: () {
                  //               myShowDialog(
                  //                    "password", newPasswordController);
                  //             },
                  //             icon: Icon(
                  //               Icons.edit,
                  //               size: 26,
                  //               color: Colors.white,
                  //             )),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  Card(
                    shadowColor: Colors.black,
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: BTNgreen,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email:    ${credential!.email} ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: BTNgreen,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Created date:  ${DateFormat('yMMMMd').format(credential!.metadata.creationTime!)}    ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: BTNgreen,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Last Signed In: ${DateFormat("yMMMMd").format(credential!.metadata.lastSignInTime!)} ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
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
            ],
          ),
        ),
      ),
    );
  }
}
