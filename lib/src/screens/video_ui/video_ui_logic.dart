import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:get/get.dart';

class VideoUiLogic extends GetxController {
  late void Function() action;
  late MediaChild currenMedia;
  final splashLogic = Get.find<SplashLogic>();
}
