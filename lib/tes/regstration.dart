import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project2/Controller/RegisreationController.dart';
import 'package:graduation_project2/Controller/authntecation.dart';
import 'package:graduation_project2/pages/Login.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/constant.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';

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

  // showmodel() {
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(22),
  //         height: 170,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             GestureDetector(
  //               onTap: () async {
  //                 await uploadImage2Screen(ImageSource.camera);
  //               },
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.camera,
  //                     size: 30,
  //                   ),
  //                   SizedBox(
  //                     width: 11,
  //                   ),
  //                   Text(
  //                     "From Camera",
  //                     style: TextStyle(fontSize: 20),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               height: 22,
  //             ),
  //             GestureDetector(
  //               onTap: () {
  //                 uploadImage2Screen(ImageSource.gallery);
  //               },
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.photo_outlined,
  //                     size: 30,
  //                   ),
  //                   SizedBox(
  //                     width: 11,
  //                   ),
  //                   Text(
  //                     "From Gallery",
  //                     style: TextStyle(fontSize: 20),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // onPasswordChanged(String password) {
  //   isPassword8Char = false;
  //   isPasswordHas1Number = false;
  //   hasUppercase = false;
  //   hasLowercase = false;
  //   hasSpecialCharacters = false;
  //   setState(() {
  //     if (password.contains(RegExp(r'.{8,}'))) {
  //       isPassword8Char = true;
  //     }

  //     if (password.contains(RegExp(r'[0-9]'))) {
  //       isPasswordHas1Number = true;
  //     }

  //     if (password.contains(RegExp(r'[A-Z]'))) {
  //       hasUppercase = true;
  //     }

  //     if (password.contains(RegExp(r'[a-z]'))) {
  //       hasLowercase = true;
  //     }

  //     if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
  //       hasSpecialCharacters = true;
  //     }
  //   });
  // }

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
        title: const Text("Register"),
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
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(125, 78, 91, 110),
                    ),
                    child: Stack(
                      children: [
                        RegistreationController.imgPath == null
                            ? const CircleAvatar(
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
                                backgroundImage: MemoryImage(
                                    RegistreationController.imgPath!),
                              ),
                        Positioned(
                          left: 99,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () async {
                              // showmodel();
                              await RegistreationController.showModel(context);

                              setState(() {});
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
                          suffixIcon: const Icon(Icons.person))),
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
                          suffixIcon: const Icon(Icons.phone))),
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
                          suffixIcon: const Icon(Icons.person_outline))),
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
                          suffixIcon: const Icon(Icons.emoji_nature))),
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
                          suffixIcon: const Icon(Icons.email))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      onChanged: (password) {
                        ///    onPasswordChanged(password);
                        RegistreationController.onPasswordChanged(password,
                            (bool is8Char, bool has1Number, bool hasUpper,
                                bool hasLower, bool hasSpecialChars) {
                          setState(() {
                            isPassword8Char = is8Char;
                            isPasswordHas1Number = has1Number;
                            hasUppercase = hasUpper;
                            hasLowercase = hasLower;
                            hasSpecialCharacters = hasSpecialChars;
                          });
                        });
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
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)))),
                  const SizedBox(
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
                              margin: const EdgeInsets.all(10),
                              child: const Icon(
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
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Farmer  "),
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
                              margin: const EdgeInsets.all(10),
                              child: const Icon(
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
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Store Owner   "),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: const Icon(
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("At least 8 charachters ")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: const Icon(
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("At least 1 number")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: const Icon(
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Has Uppercase")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: const Icon(
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Has Lowercase ")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: const Icon(
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Has Special Charactets ")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          RegistreationController.imgName != null &&
                          RegistreationController.imgPath != null &&
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
                          imgName: RegistreationController.imgName,
                          imgPath: RegistreationController.imgPath,
                          age: ageController.text,
                          situation: farmercheck == true &&
                                  storeOwnerCheck == false
                              ? "Farmer"
                              : farmercheck == false && storeOwnerCheck == true
                                  ? "Store Owner"
                                  : null,
                          balance: 100.0,
                          phoneNumber: phoneNumberController.text,
                        );
                        //  await register();
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      } else {
                        showSnackBar(context, "ERROR Form Field ");

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Register",
                            style: TextStyle(fontSize: 19),
                          ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNgreen),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12)),
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
                      const Text("Do not have an account?",
                          style: TextStyle(fontSize: 18)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          },
                          child: const Text('sign in',
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
