import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant/app_color/app_color.dart';
import '../../../../../controller/data_controller.dart';
import '../../../../widget/custom_text.dart';

class ReadHollyQuranScreen extends StatefulWidget {
  const ReadHollyQuranScreen({Key? key}) : super(key: key);

  @override
  State<ReadHollyQuranScreen> createState() => _ReadHollyQuranScreenState();
}

class _ReadHollyQuranScreenState extends State<ReadHollyQuranScreen> {
  late DataController dataController;

  int languageIndex = 0;
  late List<String> languageText;

  @override
  void initState() {
    try {
      dataController = Get.find();
    } catch (exception) {
      dataController = Get.put(DataController());
    }
    languageText = [
      dataController.dataModel[dataController.resultIndex].holyQuran!.arabic
          .toString(),
      dataController.dataModel[dataController.resultIndex].holyQuran!.urdu
          .toString(),
      dataController.dataModel[dataController.resultIndex].holyQuran!.english
          .toString()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: customTextAlignCenter(
            text:
                "Verse ( ${dataController.dataModel[dataController.resultIndex].holyQuran!.verse})",
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
      body: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppColor.deepOrangeAccentColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      setState(() {
                        languageIndex = 0;
                      });
                    },
                    child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: languageIndex == 0
                              ? AppColor.secondaryColor
                              : AppColor.secondaryColor.withOpacity(0.0),
                        ),
                        child: Center(
                            child: customTextAlignCenter(
                                text: "Arabic",
                                size: 20,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      setState(() {
                        languageIndex = 1;
                      });
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: languageIndex == 1
                              ? AppColor.secondaryColor
                              : AppColor.greenColor.withOpacity(0.0),
                        ),
                        child: Center(
                            child: customTextAlignCenter(
                                text: "Urdu",
                                size: 20,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      setState(() {
                        languageIndex = 2;
                      });
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: languageIndex == 2
                              ? AppColor.secondaryColor
                              : AppColor.greenColor.withOpacity(0.0),
                        ),
                        child: Center(
                            child: customTextAlignCenter(
                                text: "English",
                                size: 20,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: AppColor.secondaryColor,
            ),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: customTextAlignCenter(
                  text: languageText[languageIndex],
                  size: 20,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ))
        ],
      ),
    );
  }
}
