import 'package:flutter/cupertino.dart';

Widget customTextAlignCenter(
    {required String text,
    required double size,
    required Color color,
    required FontWeight fontWeight}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    ),
    textAlign: TextAlign.justify,
  );
}

Widget customTextUnderline(
    {required String text,
    required double size,
    required Color color,
    required FontWeight fontWeight}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        decoration: TextDecoration.underline),
    textAlign: TextAlign.justify,
  );
}
