import 'package:bong/src/core/models/get_new_music_model.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/models/artist_detail_model.dart'
    as artistDetailModel;
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../media_info_main/media_info_main_view.dart';

class NewMusicLogic extends GetxController {
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
    var res = await RemoteService().getNewMusicList(1);
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

  void addToFavorite() async {
    if (!GetStorage().hasData('token')) {
      EasyLoading.showToast('please login first');
      return;
    }
    EasyLoading.show(status: "Please Wait");
    await RemoteService()
        .toggleFavorite(indexLogic.selectedMusic.value!.id, "media");
    EasyLoading.showToast("SuccessFul");
    indexLogic.selectedMusic.value!.isFavourite =
        !indexLogic.selectedMusic.value!.isFavourite;
    indexLogic.selectedMusic.refresh();
  }

  void goToViewInfo(MediaChild item) {
    Get.back();
    Get.to(() => const MediaInfoMainPage(),
        arguments: {"media": artistDetailModel.Media.fromJson(item.toJson())});
  }
}
