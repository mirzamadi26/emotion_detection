import 'package:flutter/material.dart';


import '../../constant/app_color/app_color.dart';
import 'custom_text.dart';

class AboutProject extends StatefulWidget {
  const AboutProject({Key? key}) : super(key: key);

  @override
  State<AboutProject> createState() => _AboutProjectState();
}

class _AboutProjectState extends State<AboutProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: customTextAlignCenter(
            text: "Therapyx",
            size: 20,
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: AppColor.greenColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "This project is about Machine learning based Mobile Application system named therapyx that can be used to detect face Emotions. This system can be significantly useful, nonverbal way people to communicate with each other. The system classifies facial expression of the same person into the basic emotions namely anger, disgust, face, happiness, sadness and surprise. The main purpose of this system is efficient interaction between human beings and machines using eye gaze, Therapyx, cognitive modeling etc. The important thing is how fluently the system detects or extracts the facial expression from image. The system is growing attention because this could be widely used in many fields like lie detection, medical assessment and human computer interface. Here, detection and classification of facial expression can be used as a natural way for the interaction between man and machine and the system intensity vary from person and also varies along with age, gender, size and shape of face, and further, even the expressions of the same person do not remain constant with time.",
              style: TextStyle(
                color: AppColor.blackColor,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }
}
