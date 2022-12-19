import 'package:bong/src/config/string_constants.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../see_all/see_all_view.dart';

class HomeLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  Rx<int> selectedPlayListIndex = 0.obs;
  Rxn<HomeRequestModel> homeRequestModel = Rxn();
  RxList<Artist> artistList = RxList();
  RxList<MediaChild> forYouList = RxList();
  RxList<Playlist> playList = RxList();
  RxList<Media> mediaCategory = RxList();

  @override
  void onInit() {
    callHomeRequestApi();
    super.onInit();
  }

  void goToMusicPage(MediaChild mediaChild) {
    indexLogic.selectedMusic.value = mediaChild;
    Get.toNamed('/music');
  }

  void callHomeRequestApi() async {
    var res = await RemoteService().homeRequests();
    if (res[0] == null) {
      EasyLoading.showError(res[1]);
      return;
    }
    homeRequestModel.value = res[0];
    artistList.value = List.from(homeRequestModel.value!.data.artists);
    forYouList.value = List.from(homeRequestModel.value!.data.forYou);
    playList.value = List.from(homeRequestModel.value!.data.playlists);
    mediaCategory.value = List.from(homeRequestModel.value!.data.media);
  }

  void setSelectedPlayList(int index) {
    selectedPlayListIndex.value = index;
  }

  void playMusic(MediaChild mediaChild, int index) {
    indexLogic.selectedMusic.value = mediaChild;
    Get.toNamed('/music');
  }

  void goToSeeAllMedia(Media mediaCategory) {
    Get.to(() => const SeeAllPage(),
        arguments: {
          "title": mediaCategory.title.en.toString(),
          "id": mediaCategory.id.toString()
        },
        duration: const Duration(milliseconds: 500));
  }

  void goToSeeAllPlayList(Playlist playlistChild) {
    Get.to(() => const SeeAllPage(),
        arguments: {
          "title": playlistChild.title.en.toString(),
          "id": playlistChild.id.toString()
        },
        duration: const Duration(milliseconds: 500));
  }
}
