import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();

  void changeTheme() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
    }
  }
}
