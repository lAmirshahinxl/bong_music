import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:bong/src/screens/video_ui/video_ui_view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../core/models/get_new_music_model.dart';
import '../../core/models/home_requests_model.dart';
import '../../core/services/services.dart';
import '../music/music_view.dart';

class MusicVideosLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  RxList<MediaChild> mediaList = RxList();
  Rxn<GetNewMusicModel> getnewMusicModel = Rxn();

  @override
  void onInit() {
    callApi();
    super.onInit();
  }

  void callApi() async {
    var res = await RemoteService().getMusicVideos(1);
    if (res[0] == null) {
      EasyLoading.showToast(res[1].toString());
      return;
    }
    getnewMusicModel.value = res[0];
    mediaList.value = List.from(getnewMusicModel.value!.data);
  }

  void goToMusicPage(MediaChild mediaChild) {
    indexLogic.selectedMusic.value = mediaChild;
    Get.toNamed('/music');
  }

  void clickedOnItemUpnext(MediaChild mediaChild) {
    if (!mediaChild.originalSource.contains('.mp4')) {
      indexLogic.selectedMusic.value = mediaChild;
      Get.to(() => MusicPage());
    } else {
      Get.to(() => VideoUiPage(mediaChild));
    }
  }
}
