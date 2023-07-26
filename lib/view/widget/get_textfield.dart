import 'package:flutter/material.dart';

Widget getTextFeild(Size s, String key, TextEditingController controller,
    String? Function(String?)? validator) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey)),
    height: 50,
    width: s.width * 0.8,
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: TextFormField(
          obscureText: key == "Enter password" ? true : false,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintStyle: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade400),
            prefixIcon: Icon(key == "email"
                ? Icons.email_outlined
                : key == "Enter password"
                    ? Icons.password_outlined
                    : Icons.account_box),
            enabledBorder: InputBorder.none,
            hintText: key == "email"
                ? "abc123@xyz.com"
                : key == "Enter password"
                    ? "Enter password"
                    : "vehicle plate no.",
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none),
            ),
          ),
        ),
      ),
    ),
  );
}
