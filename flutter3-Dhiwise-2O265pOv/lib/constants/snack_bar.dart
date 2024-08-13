import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSnackBar(String message, context, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 3),
    ),
  );
}

SharedPreferences? preferences;
