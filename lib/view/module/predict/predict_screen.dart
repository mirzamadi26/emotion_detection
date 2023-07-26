import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../constant/assets_path/animation.dart';
import '../../../controller/data_controller.dart';
import '../../widget/custom_animation.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_loader.dart';
import '../../widget/custom_text.dart';
import '../result/result_screen.dart';

class PredictScreen extends StatefulWidget {
  const PredictScreen({Key? key}) : super(key: key);

  @override
  State<PredictScreen> createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
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
                    text: "Predict",
                    size: 20,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold),
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[AppColor.chinesePurpleColor, AppColor.crayolaColor])),
                ),
                elevation: 0,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customAnimation(
                        animation: AppAnimation.faceScanning,
                        height: 250,
                        width: 250),
                    InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () async {
                          await  dataController.pickImageFromCamera();
                          Get.defaultDialog(
                            title:dataController.resultIndex == 5
                                ? "No Face Detected"
                                : "${dataController.dataModel[dataController.resultIndex].expression}",
                            content:
                            dataController.resultIndex == 5
                                ? customLoader()
                                : Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: customImage(
                                        image: dataController.dataModel[dataController.resultIndex].image
                                            .toString(),
                                        height: 80,
                                        width: 80),
                                  ),
                                ],
                              ),
                            ),
                            onConfirm:  (){
                              Get.back;
                              Get.off(() => const ResultScreen());
                            }
                          );
                          Get.off(() => const ResultScreen());
                        },
                        child: customTextUnderline(
                            text: "Scan Your Face",
                            size: 20,
                            color: AppColor.blackColor.withOpacity(0.7),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ));
  }
}
