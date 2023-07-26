import 'package:flutter/material.dart';

import '../../../constant/app_color/app_color.dart';
import '../home/home_screen.dart';
import '../predict/predict_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Widget> navigationScreen = [HomeScreen(), PredictScreen()];
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: navigationScreen[screenIndex],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20,
          selectedFontSize: 10,
          selectedIconTheme:
              IconThemeData(color: AppColor.greenColor, size: 30),
          selectedItemColor: AppColor.greenColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: AppColor.chinesePurpleColor,
          unselectedIconTheme: IconThemeData(
            color: AppColor.crayolaColor,
          ),
          unselectedItemColor: AppColor.crayolaColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'Predict',
            ),
          ],
          currentIndex: screenIndex,
          onTap: onItemTapped,
        ));
  }

  void onItemTapped(int index) {
    setState(() {
      screenIndex = index;
    });
  }
}
