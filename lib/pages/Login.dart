// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/seconderyWidgets/My_Navigator_Widget_To_Login.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/Controller/authntecation.dart';
import 'package:graduation_project2/pages/registration.dart';
import 'package:graduation_project2/responsive/mobile.dart';
import 'package:graduation_project2/responsive/responsive.dart';
import 'package:graduation_project2/responsive/web.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/constant.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  final _formKey1 = GlobalKey<FormState>();

  // signIn() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text, password: passwordController.text);
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, "ERROR :  ${e.code} ");
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

//    getDataFromDB() async {
//  UserProvider userProvider = Provider.of(context, listen: false);
//  await userProvider.refreshUser();
//  }

//  @override
//  void initState() {
//     super.initState();
//     getDataFromDB();
//  }
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    // final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appbarGreen,
          title: Text("Sign in"),
        ),
        body: Center(
            child: Padding(
          padding: widthScreen > 600
              ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
              : const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    TextFormField(
                        key: Key('Email_TextFormField'),
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
                      height: 33,
                    ),
                    // TextField(
                    //     controller: passwordController,
                    //     keyboardType: TextInputType.text,
                    //     obscureText: isVisable ? false : true,
                    //     decoration: decorationTextfield.copyWith(
                    //         hintText: "Enter Your Password : ",
                    //         suffixIcon: IconButton(
                    //             onPressed: () {
                    //               setState(() {
                    //                 isVisable = !isVisable;
                    //               });
                    //             },
                    //             icon: isVisable
                    //                 ? Icon(Icons.visibility)
                    //                 : Icon(Icons.visibility_off)))),

                    TextFormField(
                        key: Key('Password_TextFormField'),
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

                    const SizedBox(
                      height: 33,
                    ),
                    ElevatedButton(
                      key: Key('signin_ElevatedButton'),
                      onPressed: () async {
                        if (_formKey1.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await AuthMethods().signIn(
                              emailll: emailController.text,
                              passworddd: passwordController.text,
                              context: context);

                          //  await register();
                          if (!mounted) return;
                          showSnackBar(context, "Done ... ");
                          try {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Resposive(
                                    myMobileScreen: MobileScerren(),
                                    myWebScreen: WebScerren(),
                                  ),
                                ));
                          } catch (e) {
                            showSnackBar(context, "Email or pass invalid ");
                          }
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
                              "Sign In ",
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

                    const SizedBox(
                      height: 9,
                    ),

                    Row(
                      //I fixed the row size here to max during testing @AhmedGhazi

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do not have an account?",
                            style: TextStyle(fontSize: 18)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()),
                              );
                            },
                            child: Text('sign up',
                                style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline))),
                      ],
                    ),
                  ]),
            ),
          ),
        )));
  }
}
