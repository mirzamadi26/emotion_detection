import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant/app_color/app_color.dart';
import '../../../../../controller/data_controller.dart';
import '../../../../widget/custom_text.dart';

class ReadMotivationQuotationScreen extends StatefulWidget {
  const ReadMotivationQuotationScreen({Key? key}) : super(key: key);

  @override
  State<ReadMotivationQuotationScreen> createState() =>
      _ReadMotivationQuotationScreenState();
}

class _ReadMotivationQuotationScreenState
    extends State<ReadMotivationQuotationScreen> {
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
            text: "Motivational Quotation",
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
      body: ListView.builder(
          itemCount: dataController
              .dataModel[dataController.resultIndex].quotation!.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: Get.height * 0.25,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: customTextAlignCenter(
                    text: dataController
                        .dataModel[dataController.resultIndex].quotation![index]
                        .trim(),
                    size: 15,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            );
          }),
    );
  }
}
