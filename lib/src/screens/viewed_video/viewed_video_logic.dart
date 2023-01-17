import 'package:bong/src/core/models/get_new_music_model.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/video_ui/video_ui_view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../core/services/services.dart';
import '../index/index_logic.dart';
import '../splash/splash_logic.dart';

class ViewedVideoLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  RxList<MediaChild> musicList = RxList();
  Rxn<GetNewMusicModel> getViewedMusicModel = Rxn();

  @override
  void onInit() {
    callApi();
    super.onInit();
  }

  void callApi() async {
    var res = await RemoteService().getViewedMedia(1);
    if (res[0] == null) {
      EasyLoading.showToast(res[1].toString());
      return;
    }
    getViewedMusicModel.value = res[0];
    for (var element in getViewedMusicModel.value!.data) {
      if (element.type == "musicvideo") {
        musicList.add(element);
      }
    }
  }

  void goToVideoPage(MediaChild music) {
    Get.to(() => VideoUiPage(music), duration: const Duration(seconds: 1));
  }
}
