import 'package:flutter/material.dart';

class Helpers {
  static void showSnackBar(String message, Color color, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
