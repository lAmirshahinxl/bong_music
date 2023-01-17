import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/music/music_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:bong/src/screens/video_ui/video_ui_logic.dart';
import 'package:get/get.dart';

class MediaInfoLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();
  late var musicLogic;
  Rx<String> artistText = ''.obs;
  @override
  void onInit() {
    try {
      musicLogic = Get.find<MusicLogic>();
    } catch (e) {
      musicLogic = Get.find<VideoUiLogic>();
    }
    setArtistText();
    super.onInit();
  }

  void setArtistText() {
    for (var element in musicLogic.detailMediaModel.value!.data.artists) {
      artistText.value = " ${artistText.value}& ${element.name}";
    }
  }
}
