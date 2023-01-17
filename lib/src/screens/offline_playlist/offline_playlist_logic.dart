import 'package:bong/src/config/string_constants.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:bong/src/screens/video_ui/video_ui_view.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OfflinePlaylistLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  RxList<File> myList = RxList();
  @override
  void onInit() {
    setMyList();
    super.onInit();
  }

  void setMyList() async {
    myList.clear();
    for (var element in indexLogic.offlineMusicUrlList) {
      var data = await DefaultCacheManager().getFileFromCache(
          "$imageBaseUrlWithoutSlash${element.originalSource}");
      if (data != null) {
        myList.add(data.file);
      }
    }
  }

  void clickedOnItem(int index) async {
    if (indexLogic.offlineMusicUrlList[index].originalSource.contains('.mp4')) {
      Get.to(() => VideoUiPage(
            indexLogic.offlineMusicUrlList[index],
            offlineFile: myList[index],
          ));
    } else {
      indexLogic.selectedMusic.value = indexLogic.offlineMusicUrlList[index];
      indexLogic.audioPlayer.setFilePath(myList[index].path);
      indexLogic.audioPlayer.play();
    }
  }

  void removeAllCaches() async {
    Get.back();
    await DefaultCacheManager().emptyCache();
    GetStorage().remove('offlineMusic');
    indexLogic.getOfflineMusics();
    setMyList();
    EasyLoading.showToast("Successful");
  }
}
