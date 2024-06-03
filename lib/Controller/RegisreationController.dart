import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RegistreationController {

    


 static Uint8List? imgPath;
  static String? imgName;

  static Future<void> uploadImage2Screen(BuildContext context, ImageSource source) async {
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        imgName = basename(pickedImg.path);
        int random = Random().nextInt(9999999);
        imgName = "$random$imgName";
        print(imgName);
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  static Future<void> showModel(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(context, ImageSource.camera);
                  Navigator.pop(context);
                },
                child: const Row(
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
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(context, ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: const Row(
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



static void onPasswordChanged(String password, Function(bool, bool, bool, bool, bool) setState) {
    bool isPassword8Char = false;
    bool isPasswordHas1Number = false;
    bool hasUppercase = false;
    bool hasLowercase = false;
    bool hasSpecialCharacters = false;

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

    setState(isPassword8Char, isPasswordHas1Number, hasUppercase, hasLowercase, hasSpecialCharacters);
  }


  
}