import 'package:bong/src/config/languages/language.dart';
import 'package:bong/src/config/string_constants.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  final logic = Get.put(SplashLogic());

  SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Image.asset(
      'assets/images/logo-min.png',
      width: Get.width * 0.7,
      height: Get.width * 0.7,
    )));
  }
}
