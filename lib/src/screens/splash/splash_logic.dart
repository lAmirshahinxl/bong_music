import 'package:bong/src/config/languages/language.dart';
import 'package:get/get.dart';

import '../../config/languages/english_language.dart';

class SplashLogic extends GetxController {
  late RxMap currentLanguage;
  @override
  void onInit() {
    currentLanguage = RxMap(Language().getCurrentLanguage());
    super.onInit();
    setTimer();
  }

  void changeLanguage(String text) {
    Language().setCurrentLanguage(text);
    currentLanguage.value = Language().getCurrentLanguage();
  }

  void setTimer() {
    Future.delayed(
      const Duration(seconds: 4),
      () => Get.offAllNamed('/index'),
    );
  }
}
