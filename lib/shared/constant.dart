import 'package:flutter/material.dart';
import 'package:graduation_project2/shared/colors.dart';

const decorationTextfield = InputDecoration(
  
  // To delete borders
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color:BTNgreen,
    ),
  ),
  // fillColor: Colors.red,
  filled: true,
  contentPadding: EdgeInsets.all(8),
);