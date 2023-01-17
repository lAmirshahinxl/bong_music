import 'package:bong/src/core/models/get_new_music_model.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../core/services/services.dart';
import '../index/index_logic.dart';
import '../splash/splash_logic.dart';

class ViewedMusicLogic extends GetxController {
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
    musicList.value = List.from(getViewedMusicModel.value!.data);
  }

  goToMusicPage(MediaChild music) {
    indexLogic.selectedMusic.value = music;
    Get.toNamed('/music');
  }
}
