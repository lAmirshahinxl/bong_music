import 'package:bong/src/core/models/artist_detail_model.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ArtistDetailLogic extends GetxController {
  late Artist currentArtist;
  Rxn<ArtistDetailModel> artistDetailModel = Rxn();
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();

  @override
  void onReady() {
    super.onReady();
    callArtisDetailApi();
  }

  void callArtisDetailApi() async {
    var res = await RemoteService().getArtistDetail(currentArtist.id);
    if (res[0] == null) {
      EasyLoading.showToast(res[1].toString());
      return;
    }
    artistDetailModel.value = res[0];
  }

  void goToMusicPage(MediaChild mediaChild) {
    indexLogic.selectedMusic.value = mediaChild;
    Get.toNamed('/music');
  }
}
