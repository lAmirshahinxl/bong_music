import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/music/music_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:bong/src/screens/video_ui/video_ui_logic.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:bong/src/core/models/artist_detail_model.dart' as artistdetail;

class MediaInfoMainLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();
  final artistdetail.Media? selectedMedia = Get.arguments['media'];
  Rx<String> artistText = ''.obs;
  @override
  void onInit() {
    if (selectedMedia == null) {
      EasyLoading.showToast("Not found any description");
      Get.back();
    } else {
      setArtistText();
    }
    super.onInit();
  }

  void setArtistText() {
    for (var element in selectedMedia!.artists) {
      artistText.value = " ${artistText.value}& ${element.name}";
    }
  }
}
