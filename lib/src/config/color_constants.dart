import 'dart:ui';
import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color lightScaffoldBackgroundColor = hexToColor('#EBEBEB');
  static Color darkScaffoldBackgroundColor = Colors.transparent;
  static Color secondaryAppColor = hexToColor('#5E92F3');
  static Color secondaryDarkAppColor = Colors.white;
  static Color gold = const Color(0xffFFD700);
  static Color backgroundColor = const Color(0xff303030);
  static Color cardbackground = const Color.fromARGB(174, 44, 44, 44);
  static Color cardbackgroundFull = const Color.fromARGB(0, 44, 44, 44);
}
