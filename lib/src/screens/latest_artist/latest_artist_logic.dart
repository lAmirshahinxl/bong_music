import 'package:bong/src/core/models/get_latest_artist_model.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../core/services/services.dart';
import '../index/index_logic.dart';
import '../splash/splash_logic.dart';

class LatestArtistLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  RxList<Artist> artistList = RxList();
  Rxn<GetLatestArtistModel> getLatestArtistModel = Rxn();

  @override
  void onInit() {
    callApi();
    super.onInit();
  }

  void callApi() async {
    var res = await RemoteService().getViewedArtist(1);
    if (res[0] == null) {
      EasyLoading.showToast(res[1].toString());
      return;
    }
    getLatestArtistModel.value = res[0];

    artistList.value = List.from(getLatestArtistModel.value!.data);
  }
}
