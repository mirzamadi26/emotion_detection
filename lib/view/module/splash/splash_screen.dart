import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapyx/service/splash_service.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../constant/assets_path/app_logo.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';
import '../welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashServices splashServives = SplashServices();
    splashServives.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customLogo(image: AppLogo.appLogo, height: 250, width: 300),
                Text(
                    "This project is about Machine learning based Mobile Application system named \"Therapyx\" that can be used to detect face Emotions.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
