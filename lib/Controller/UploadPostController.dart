import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class PostController {
  static Uint8List? imgPath;
  static String? imgName;

  static Future<void> uploadImage2Screen(
      BuildContext context, ImageSource source) async {
     Navigator.pop(context);

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
        showSnackBar(context, """""" """""text""" """""" "");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  static Future<void> showModel(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(children: [
          SimpleDialogOption(
            onPressed: () async {
              // Navigator.of(context).pop();
              await uploadImage2Screen(context, ImageSource.camera);
            },
            padding: EdgeInsets.all(20),
            child: Text(
              "From Camera",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              // Navigator.of(context).pop();
              await uploadImage2Screen(context, ImageSource.gallery);
            },
            padding: EdgeInsets.all(20),
            child: Text(
              "From Gallary",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ]);
      },
    );
  }

}
