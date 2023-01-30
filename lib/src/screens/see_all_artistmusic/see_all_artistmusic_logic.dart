import 'package:bong/src/config/string_constants.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/media_info_main/media_info_main_view.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:bong/src/core/models/artist_detail_model.dart' as artistdetail;
import 'package:get_storage/get_storage.dart';

import '../../core/services/services.dart';
import '../index/index_logic.dart';
import '../splash/splash_logic.dart';

class SeeAllArtistMusicLogic extends GetxController {
  final List<artistdetail.Media> musicList = Get.arguments['musicList'] ?? [];
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();

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

  void goToViewInfo(artistdetail.Media item) {
    Get.back();
    Get.to(() => const MediaInfoMainPage(), arguments: {"media": item});
  }

  void downloadMusic(MediaChild mediaChild) async {
    EasyLoading.show(status: "Downloading");
    var fileInfo = await DefaultCacheManager().getFileFromCache(
        "$imageBaseUrlWithoutSlash${mediaChild.originalSource}");
    if (fileInfo == null) {
      var file = await DefaultCacheManager().getSingleFile(
          "$imageBaseUrlWithoutSlash${mediaChild.originalSource}");
      indexLogic.addOfflineMusic(mediaChild);
      EasyLoading.showToast('File Added To Your PlayList');
    } else {
      EasyLoading.showToast('File Already Added To Playlist');
    }
  }
}
