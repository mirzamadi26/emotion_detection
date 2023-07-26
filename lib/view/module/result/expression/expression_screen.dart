import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../constant/app_color/app_color.dart';
import '../../../../controller/data_controller.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import '../result_as_you_are/as_you_are_screen.dart';

class ExpressionScreen extends StatefulWidget {
  const ExpressionScreen({Key? key}) : super(key: key);

  @override
  State<ExpressionScreen> createState() => _ExpressionScreenState();
}

class _ExpressionScreenState extends State<ExpressionScreen> {
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
      backgroundColor: AppColor.primaryColor.withOpacity(0.8),
      appBar: AppBar(
        title: customTextAlignCenter(
            text: "Expressions",
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
      body: Padding(
        padding: EdgeInsets.all(5),
          child: ListView.builder(
              itemCount: dataController.dataModel.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    dataController.manuallySetResult(index);
                    Get.to(() => const AsYouAreScreen());
                  },
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: customImage(
                                image: dataController.dataModel[index].image
                                    .toString(),
                                height: 80,
                                width: 80),
                        ),
                       
                        Expanded(
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customTextAlignCenter(
                                    text: dataController.dataModel[index].expression
                                        .toString(),
                                    size: 20,
                                    color: AppColor.deepOrangeAccentColor,
                                    fontWeight: FontWeight.bold),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: customTextAlignCenter(
                                      text: dataController.dataModel[index].quotation![0]
                                          .toString(),
                                      size: 15,
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

                        ),
                       
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
