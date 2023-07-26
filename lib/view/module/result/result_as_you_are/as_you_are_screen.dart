import 'package:therapyx/view/module/result/result_as_you_are/read_holly_quran/read_holly_quran_screen.dart';
import 'package:therapyx/view/module/result/result_as_you_are/read_quotation/read_quotation_screen.dart';
import 'package:therapyx/view/module/result/result_as_you_are/watch_video/watch_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/app_color/app_color.dart';
import '../../../../controller/data_controller.dart';
import '../../../widget/custom_text.dart';
import 'listen_audio/listen_audio_screen.dart';

class AsYouAreScreen extends StatefulWidget {
  const AsYouAreScreen({Key? key}) : super(key: key);

  @override
  State<AsYouAreScreen> createState() => _AsYouAreScreenState();
}

class _AsYouAreScreenState extends State<AsYouAreScreen> {
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
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: customTextAlignCenter(
            text:
                "As You Are ${dataController.dataModel[dataController.resultIndex].expression}",
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {
                  Get.to(() => const ReadHollyQuranScreen());
                },
                child: Container(
                  height: Get.height * 0.2,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.chinesePurpleColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: customTextAlignCenter(
                        text: "Read According to Holy Quran",
                        size: 20,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {
                  Get.to(() => const ReadMotivationQuotationScreen());
                },
                child: Container(
                  height: Get.height * 0.2,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.chinesePurpleColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: customTextAlignCenter(
                        text: "Read Motivational Quotation",
                        size: 20,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {
                  Get.to(() => const ListenAudioScreen());
                },
                child: Container(
                  height: Get.height * 0.2,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.chinesePurpleColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: customTextAlignCenter(
                        text: "Listen Audio",
                        size: 20,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {
                  Get.to(() => const WatchVideoScreen());
                },
                child: Container(
                  height: Get.height * 0.2,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.chinesePurpleColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: customTextAlignCenter(
                        text: "Watch Video",
                        size: 20,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
