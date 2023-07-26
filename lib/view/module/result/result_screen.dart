import 'dart:io';

import 'package:therapyx/view/module/result/result_as_you_are/as_you_are_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../controller/data_controller.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_loader.dart';
import '../../widget/custom_text.dart';
import '../home/consultdoctor_screen.dart';
import 'expression/expression_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late DataController dataController;

  @override
  void initState() {
    try {
      dataController = Get.find();
    } catch (exception) {
      dataController = Get.put(DataController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
        builder: (dataController) => Scaffold(
              backgroundColor: AppColor.primaryColor,
              appBar: AppBar(
                title: customTextAlignCenter(
                    text: "Result",
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
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    dataController.imageFile != null
                        ? Container(
                            height: Get.height * 0.3,
                            width: Get.width,
                            padding: const EdgeInsets.all(10),
                            child: Image.file(
                              File(
                                dataController.imageFile!.path,
                              ),
                              fit: BoxFit.fill,
                            ),
                          )
                        : customLoader(),
                    Container(
                      height: Get.height * 0.3,
                      width: Get.width,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor.chinesePurpleColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: customTextAlignCenter(
                                text: dataController.resultIndex == 5
                                    ? "No Face Detected"
                                    : dataController
                                        .dataModel[dataController.resultIndex]
                                        .expression
                                        .toString(),
                                size: 30,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          dataController.resultIndex == 5
                              ? Container()
                              : Flexible(
                                  child: customImage(
                                      image: dataController
                                          .dataModel[dataController.resultIndex]
                                          .image
                                          .toString(),
                                      height: 100,
                                      width: 100),
                                )
                        ],
                      ),
                    ),
                    InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        if (dataController.resultIndex != 5) {
                          Get.to(() => const AsYouAreScreen());
                        } else {
                          Get.snackbar(
                              "Failed", "No Face Detected , Scan Again ",
                              duration: const Duration(seconds: 2));
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 250,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColor.amberAccentColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: customTextAlignCenter(
                              text: "Detected Emotion is correct ?",
                              size: 15,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 250,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColor.crayolaColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: customTextAlignCenter(
                              text: "Detect Again",
                              size: 15,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        Get.to(() => const ExpressionScreen());
                      },
                      child: Container(
                        height: 40,
                        width: 250,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: customTextAlignCenter(
                              text: "Select Manually",
                              size: 15,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    if (dataController.resultIndex == 4)
                      InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          Get.to(() => const ConsultDoctor());
                        },
                        child: Container(
                          height: 40,
                          width: 250,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColor.blackColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: customTextAlignCenter(
                              text: "Consult Doctor",
                              size: 15,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ));
  }
}
