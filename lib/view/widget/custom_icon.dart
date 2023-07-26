import 'package:flutter/cupertino.dart';

Widget customIcon(
    {required IconData icon, required Color color, required double size}) {
  return Icon(
    icon,
    color: color,
    size: size,
  );
}
