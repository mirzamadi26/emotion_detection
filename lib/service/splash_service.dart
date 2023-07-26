import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:therapyx/view/module/auth/login_screen.dart';
import 'package:therapyx/view/module/welcome/welcome_screen.dart';

import '../view/module/home/home_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final _user = await _auth.currentUser;
    if (_user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => WelcomeScreen())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }
}
