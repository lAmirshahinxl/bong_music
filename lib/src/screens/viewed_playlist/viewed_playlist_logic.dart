import 'package:bong/src/core/models/get_viewed_playlist_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../core/models/home_requests_model.dart';
import '../../core/services/services.dart';
import '../index/index_logic.dart';
import '../splash/splash_logic.dart';

class ViewedPlaylistLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  RxList<PlaylistChild> playList = RxList();
  Rxn<GetViewedPlaylist> getViewedPlaylistModel = Rxn();

  @override
  void onInit() {
    callApi();
    super.onInit();
  }

  void callApi() async {
    var res = await RemoteService().getViewdPlaylist(1);
    if (res[0] == null) {
      EasyLoading.showToast(res[1].toString());
      return;
    }
    getViewedPlaylistModel.value = res[0];
    playList.value = List.from(getViewedPlaylistModel.value!.data);
  }
}
