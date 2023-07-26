import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

Widget customAnimation(
    {required String animation,
    required double height,
    required double width}) {
  return Lottie.asset(animation, height: height, width: 250, fit: BoxFit.fill);
}
