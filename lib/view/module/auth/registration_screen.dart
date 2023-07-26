// ignore_for_file: use_build_context_synchronously

import 'package:custom_signin_buttons/button_data.dart';
import 'package:custom_signin_buttons/button_list.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:therapyx/constant/app_color/app_color.dart';
import 'package:therapyx/constant/assets_path/animation.dart';
import 'package:therapyx/view/module/auth/login_screen.dart';
import 'package:therapyx/view/widget/button_icon.dart';

import '../../../service/authService.dart';
import '../../widget/custom_text.dart';
import '../../widget/get_textfield.dart';
import '../../widget/progress_dialog.dart';
import '../../widget/snackbar.dart';
import '../welcome/welcome_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    super.key,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isLoading = false;

  String errorMsg = '';

  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final FirebaseAuthService _authService = FirebaseAuthService();
  void _registerUser() async {
// Show the progress dialog while waiting for registration
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ProgressDialog(status: 'Registering...');
      },
    );

    _authService.registerWithEmailAndPassword(
      _emailIdController.text,
      _passwordController.text,
      (success, error) {
        // Registration finished, hide the progress dialog
        Navigator.pop(context);

        setState(() {
          isLoading = false;
          errorMsg = error;
        });

        if (success) {
          // Registration success, navigate to the next screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        }
        _showSnackBar('Registration successful!', Colors.green);
      },
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _showProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(status: 'Please Wait...');
      },
    );
  }

  void _signInWithGoogle() async {
    setState(() {
      isLoading = true;
      errorMsg = '';
    });

    // Show the progress dialog while waiting for Google Sign-In
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ProgressDialog(status: 'Signing in with Google...');
      },
    );

    final User? user = await _authService.signInWithGoogle();

    // Google Sign-In finished, hide the progress dialog
    Navigator.pop(context);

    setState(() {
      isLoading = false;
    });

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    } else {
      final snackBar = SnackBar(
        content: Text('Google Sign-In canceled or failed'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: customTextAlignCenter(
            text: "TherapyX",
            size: 20,
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                AppColor.chinesePurpleColor,
                AppColor.crayolaColor
              ])),
        ),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: AppColor.viridianGreenColor),
                    height: s.height * 0.25,
                    width: s.width * 0.8,
                    child: Center(
                      child: Lottie.asset(AppAnimation.signUpScanning,
                          width: s.width * 0.6,
                          height: s.height * 0.3,
                          reverse: true),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: getTextFeild(
                    s,
                    "email",
                    _emailIdController,
                    ((v) {
                      return null;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: getTextFeild(
                    s,
                    "Enter password",
                    _passwordController,
                    ((v) {
                      return null;
                    }),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(12),
                    child: MaterialButton(
                        textColor: AppColor.blackColor,
                        height: 50,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: Colors.blueGrey)),
                        minWidth: s.width * 0.8,
                        color: AppColor.secondaryColor,
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        onPressed: () {
                          String email = _emailIdController.text;

                          String pass = _passwordController.text;
                          bool isEmailValid = EmailValidator.validate(email);
                          if (!isEmailValid) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Email Invalid")));
                            return;
                          } else if (_passwordController.text.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Password length is too short (Max 6)")));
                            return;
                          } else if (_passwordController.text.isEmpty ||
                              email.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Email or Password field is empty")));
                            return;
                          }
                          _registerUser();
                        })),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonwithIconWidget(
                    backgroundColor: Colors.white,
                    text: "Sign in with Google",
                    textColor: Colors.black87,
                    function: () {
                      _signInWithGoogle();
                    }),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Already have an Account?",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                    child: Text("Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
