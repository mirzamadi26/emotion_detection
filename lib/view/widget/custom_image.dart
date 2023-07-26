import 'package:flutter/cupertino.dart';

Widget customImage(
    {required String image, required double height, required double width}) {
  return Image.asset(
    image,
    height: height,
    width: width,
    fit: BoxFit.cover,
  );
}
Widget customLogo(
    {required String image, required double height, required double width}) {
  return Image.asset(
    image,
    height: height,
    width: width,
  );
}
