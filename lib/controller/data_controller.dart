import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/data_model.dart';

class DataController extends GetxController {
  List<DataModel> dataModel = [];
  String result = " ";
  XFile? imageFile;

  int resultIndex = 5;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    readJson();
    loadModel();
  }

  Future readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final data = await json.decode(response);
    dataModel =
        List<DataModel>.from(data.map((value) => DataModel.fromJson(value)));
  }

  void setIndex() async {
    resultIndex = 5;
    for (var element in dataModel) {
      if (element.expression!.toUpperCase().trim() ==
          result.toUpperCase().trim()) {
        resultIndex = dataModel.indexOf(element);
      }
    }
    update();
  }

  void manuallySetResult(int index) async {
    result = dataModel[index].expression.toString();
    setIndex();
  }

  runModel() async {
    var prediction = await Tflite.runModelOnImage(
        path: imageFile!.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    for (var element in prediction!) {
      result = element['label'];
    }
    result = result.substring(result.indexOf(" "));
    setIndex();
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/ml_model/model_unquant.tflite",
        labels: "assets/ml_model/labels.txt");
  }

  pickImageFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = pickedFile;
    }
    runModel();
  }

  pickImageFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = pickedFile;
    }
    runModel();
  }
}
