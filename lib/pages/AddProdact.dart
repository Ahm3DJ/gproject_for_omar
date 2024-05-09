// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/Controller/UploadPostController.dart';
import 'package:graduation_project2/Controller/fireStore.dart';
import 'package:graduation_project2/model/User.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/constant.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' show basename;
import 'package:provider/provider.dart';

class AddProdact extends StatefulWidget {
  const AddProdact({Key? key}) : super(key: key);

  @override
  State<AddProdact> createState() => _AddProdactState();
}

class _AddProdactState extends State<AddProdact> {
  final descrbtionController = TextEditingController();
  final captionController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final prodactNameController = TextEditingController();

  Uint8List? imgPath;
  String? imgName;

  bool isLoading = false;

  // uploadImage2Screen(ImageSource source) async {
  //   Navigator.pop(context);
  //   final XFile? pickedImg = await ImagePicker().pickImage(source: source);
  //   try {
  //     if (pickedImg != null) {
  //       imgPath = await pickedImg.readAsBytes();
  //       setState(() {
  //         imgName = basename(pickedImg.path);
  //         int random = Random().nextInt(9999999);
  //         imgName = "$random$imgName";
  //         print(imgName);
  //       });
  //     } else {
  //       print("NO img selected");
  //     }
  //   } catch (e) {
  //     print("Error => $e");
  //   }
  // }

  bool fruitProdact = false;
  bool vegetableProdact = false;
  bool anotherProdact = false;

  // showmodel() {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SimpleDialog(
  //         children: [
  //           SimpleDialogOption(
  //             onPressed: () async {
  //               // Navigator.of(context).pop();
  //               await uploadImage2Screen(ImageSource.camera);
  //             },
  //             padding: EdgeInsets.all(20),
  //             child: Text(
  //               "From Camera",
  //               style: TextStyle(
  //                 fontSize: 18,
  //               ),
  //             ),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () async {
  //               // Navigator.of(context).pop();
  //               await uploadImage2Screen(ImageSource.gallery);
  //             },
  //             padding: EdgeInsets.all(20),
  //             child: Text(
  //               "From Gallary",
  //               style: TextStyle(
  //                 fontSize: 18,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    ///  final allDataFromDB = Provider.of<UserProvider>(context).getUser;
    UserProvider userProvider = Provider.of(context, listen: false);
    userProvider.refreshUser();
    UserDete? userData = userProvider.getUser;
    print("cccccccccccccccccc${userData!.username}");
    return PostController.imgPath == null
        ? Scaffold(
            backgroundColor: scaffoldColor,
            body: Center(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      //showmodel();
                      PostController.showModel(context);
                    });
                  },
                  icon: Icon(
                    Icons.upload,
                    size: 55,
                  )),
            ),
          )
        : Scaffold(
            backgroundColor: scaffoldColor,
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await FireBase().uploadPost(
                        imgName: PostController.imgName,
                        imgPath: PostController.imgPath,
                        description: descrbtionController.text,
                        profileImg: userData.profileImg,
                        username: userData.username,
                        context: context,
                        price: priceController.text,
                        caption: captionController.text,
                        quntity: quantityController.text,
                        title: userData.title,
                        prodactName: prodactNameController.text,
                        typeOfProdact: fruitProdact == true &&
                                vegetableProdact == false &&
                                anotherProdact == false
                            ? "Fruits"
                            : fruitProdact == false &&
                                    vegetableProdact == true &&
                                    anotherProdact == false
                                ? "Vegetables"
                                : fruitProdact == false &&
                                        vegetableProdact == false &&
                                        anotherProdact == true
                                    ? "Other"
                                    : null,
                        phoneNumber: userData.phoneNumber,
                      );

                      setState(() {
                        isLoading = false;
                        PostController.imgPath = null;
                      });
                    },
                    child: const Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    )),
              ],
              backgroundColor: BTNgreen,
              leading: IconButton(
                  onPressed: () {
                    setState(() {
                      PostController.imgPath = null;
                    });
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  isLoading
                      ? LinearProgressIndicator()
                      : Divider(
                          thickness: 1,
                          height: 30,
                        ),
                  Container(
                    decoration: BoxDecoration(
                        color: contantPost,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    //  padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(125, 78, 91, 110),
                                    ),
                                    child: CircleAvatar(
                                      radius: 33,
                                      backgroundImage:
                                          NetworkImage(userData.profileImg
                                              // widget.snap["profileImg"],
                                              ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 17,
                                  ),
                                  Text(
                                    // widget.snap["username"],
                                    userData.username,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.35,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(PostController.imgPath!),
                                  fit: BoxFit.cover
                                  //
                                  //
                                  )),
                        ),
                        Form(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            fruitProdact = true;
                                            vegetableProdact = false;
                                            anotherProdact = false;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: fruitProdact
                                                  ? Colors.green
                                                  : Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Fruits  "),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            vegetableProdact = true;
                                            fruitProdact = false;
                                            anotherProdact = false;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: vegetableProdact
                                                  ? Colors.green
                                                  : Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Vegetables "),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            anotherProdact = true;
                                            vegetableProdact = false;
                                            fruitProdact = false;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: anotherProdact
                                                  ? Colors.green
                                                  : Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Another Prodact "),
                                    ],
                                  ),
                                ],
                              ),
                              TextFormField(
                                  validator: (value) {
                                    return value!.isEmpty || value.length < 2
                                        ? "Can not be less than 2 char"
                                        : null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: prodactNameController,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                  decoration: decorationTextfield.copyWith(
                                      hintText: "Enter Prodact Name   ",
                                      suffixIcon: Icon(Icons.comment_sharp))),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    return value!.isEmpty || value.length < 2
                                        ? "Can not be less than 2 char"
                                        : null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: captionController,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                  decoration: decorationTextfield.copyWith(
                                      hintText:
                                          "Write a caption to post ....  ",
                                      suffixIcon: Icon(Icons.comment_sharp))),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    return value!.isEmpty || value.length < 2
                                        ? "Can not be less than 2 char"
                                        : null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: quantityController,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  decoration: decorationTextfield.copyWith(
                                      hintText: "Enter quantity  : ",
                                      suffixIcon: Icon(Icons
                                          .production_quantity_limits_sharp))),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    return value!.isEmpty || value.length < 2
                                        ? "Can not be less than 2 char"
                                        : null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  decoration: decorationTextfield.copyWith(
                                      hintText: "Enter Price for 1 KG:",
                                      suffixIcon:
                                          Icon(Icons.price_change_outlined))),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    return value!.isEmpty || value.length < 5
                                        ? "Can not be less than 5 char"
                                        : null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: descrbtionController,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                  decoration: decorationTextfield.copyWith(
                                      hintText:
                                          "Enter Description  for prodact : ",
                                      suffixIcon: Icon(Icons.description))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
