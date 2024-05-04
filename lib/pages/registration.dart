// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project2/firebase/authntecation.dart';
import 'package:graduation_project2/pages/Login.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/constant.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isVisable = true;
  Uint8List? imgPath;
  String? imgName;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  final phoneNumberController = TextEditingController();
  bool isPassword8Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  bool farmercheck = false;
  bool storeOwnerCheck = false;

  // uploadImage2Screen(ImageSource source) async {
  //   final pickedImg = await ImagePicker().pickImage(source: source);
  //   try {
  //     if (pickedImg != null) {
  //       setState(() {
  //         imgPath = File(pickedImg.path);
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

  //   if (!mounted) return;
  //   Navigator.pop(context);
  // }

  uploadImage2Screen(ImageSource source) async {
    Navigator.pop(context);
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  onPasswordChanged(String password) {
    isPassword8Char = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        isPasswordHas1Number = true;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      }
    });
  }

//   register() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final credential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );

// // Upload image to firebase storage
//       final storageRef = FirebaseStorage.instance.ref("users-imgs/$imgName");
//       await storageRef.putFile(imgPath!);
//       String urll = await storageRef.getDownloadURL();

//       print(credential.user!.uid);

//       CollectionReference users =
//           FirebaseFirestore.instance.collection('userSSS');

//       users
//           .doc(credential.user!.uid)
//           .set({
//             "imgLink":   urll     ,
//             'username': usernameController.text,
//             'age': ageController.text,
//             "title": titleController.text,
//             "email": emailController.text,
//             "pass": passwordController.text,
//           })
//           .then((value) => print("User Added"))
//           .catchError((error) => print("Failed to add user: $error"));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         showSnackBar(context, "The password provided is too weak.");
//       } else if (e.code == 'email-already-in-use') {
//         showSnackBar(context, "The account already exists for that email.");
//       } else {
//         showSnackBar(context, "ERROR - Please try again late");
//       }
//     } catch (err) {
//       showSnackBar(context, err.toString());
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();

    usernameController.dispose();
    ageController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register"),
        // elevation: 0,
        backgroundColor: appbarGreen,
      ),
      body: Center(
        child: Padding(
          padding: widthScreen > 600
              ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
              : const EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(125, 78, 91, 110),
                    ),
                    child: Stack(
                      children: [
                        imgPath == null
                            ? CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 225, 225, 225),
                                radius: 71,
                                // backgroundImage: AssetImage("assets/img/avatar.png"),
                                backgroundImage:
                                    AssetImage("assets/avatarImage.jpg"),
                              )
                            : CircleAvatar(
                                radius: 71,
                                // backgroundImage: AssetImage("assets/img/avatar.png"),
                                backgroundImage: MemoryImage(imgPath!),
                              ),
                        Positioned(
                          left: 99,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () {
                              showmodel();
                            },
                            icon: const Icon(Icons.add_a_photo),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                      validator: (value) {
                        return value!.isEmpty || value.length < 5
                            ? "Can not be less than 5 char"
                            : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your username : ",
                          suffixIcon: Icon(Icons.person))),
      const SizedBox(
                    height: 22,
                  ),
            


                      TextFormField(
                      validator: (value) {
                        return value!.isEmpty || value.length < 10
                            ? "Can not be less than 10 numbers"
                            : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your Phone Number : ",
                          suffixIcon: Icon(Icons.phone))),






                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      validator: (value) {
                        return value!.isEmpty ? "Can not be empty" : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your title : ",
                          suffixIcon: Icon(Icons.person_outline))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      // validator: (value) {
                      //       return value.(Int.parse()) < 8
                      //           ? "Enter at least 8 characters"
                      //           : null;
                      //     },
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your age : ",
                          suffixIcon: Icon(Icons.emoji_nature))),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                      // we return "null" when something is valid
                      validator: (email) {
                        return email!.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                            ? null
                            : "Enter a valid email";
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your Email : ",
                          suffixIcon: Icon(Icons.email))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      onChanged: (password) {
                        onPasswordChanged(password);
                      },
                      // we return "null" when something is valid
                      validator: (value) {
                        return value!.length < 8
                            ? "Enter at least 8 characters"
                            : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: isVisable ? true : false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your Password : ",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisable = !isVisable;
                                });
                              },
                              icon: isVisable
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)))),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                farmercheck = true;
                                storeOwnerCheck = false;
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
                                  color:
                                      farmercheck ? Colors.green : Colors.white,
                                  border: Border.all(color: Colors.grey)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Farmer  "),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                storeOwnerCheck = true;
                                farmercheck = false;
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
                                  color: storeOwnerCheck
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(color: Colors.grey)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Store Owner   "),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isPassword8Char ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("At least 8 charachters ")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPasswordHas1Number
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(color: Colors.grey)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("At least 1 number")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasUppercase ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Has Uppercase")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasLowercase ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Has Lowercase ")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasSpecialCharacters
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(color: Colors.grey)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Has Special Charactets ")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          imgName != null &&
                          imgPath != null &&
                          (farmercheck || storeOwnerCheck)) {
                        setState(() {
                          isLoading = true;
                        });
                        await AuthMethods().register(
                          emailll: emailController.text,
                          passworddd: passwordController.text,
                          context: context,
                          titleee: titleController.text,
                          usernameee: usernameController.text,
                          imgName: imgName,
                          imgPath: imgPath,
                          age: ageController.text,
                          situation: farmercheck == true &&
                                  storeOwnerCheck == false
                              ? "Farmer"
                              : farmercheck == false && storeOwnerCheck == true
                                  ? "Store Owner"
                                  : null,
                          balance: 100.0, phoneNumber: phoneNumberController.text,
                        );
                        //  await register();
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      } else {
                        showSnackBar(context, "ERROR Form Field ");

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Register",
                            style: TextStyle(fontSize: 19),
                          ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNgreen),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do not have an account?",
                          style: TextStyle(fontSize: 18)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text('sign in',
                              style: TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.underline))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
