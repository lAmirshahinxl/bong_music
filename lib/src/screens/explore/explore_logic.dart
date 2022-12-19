import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/home/home_logic.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../core/models/artist_detail_model.dart' as artistDeatilModel;
import '../../core/services/services.dart';
import '../splash/splash_logic.dart';

class ExploreLogic extends GetxController {
  List<Map> tabListStatics = [];
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  final homeLogic = Get.find<HomeLogic>();
  Rxn<HomeRequestModel> homeRequestModel = Rxn();
  RxList<artistDeatilModel.Story> storyList = RxList();
  RxList<Playlist> playList = RxList();
  RxList<Media> mediaCategory = RxList();

  @override
  void onInit() {
    settabListData();
    ever(
      splashLogic.currentLanguage,
      (callback) => settabListData(),
    );
    super.onInit();
    callExploreApi();
  }

  void settabListData() {
    tabListStatics.clear();
    tabListStatics.addAll([
      {
        "name": splashLogic.currentLanguage['newMusic'],
        "icon": Icons.music_note_rounded
      },
      {
        "name": splashLogic.currentLanguage['musicVideos'],
        "icon": Icons.video_collection_rounded
      },
      {
        "name": splashLogic.currentLanguage['latestPodcasts'],
        "icon": Icons.podcasts_rounded
      },
      {
        "name": splashLogic.currentLanguage['upcomingEvents'],
        "icon": Icons.event_available_rounded
      },
    ]);
  }

  void gotoMusicPage(MediaChild mediaChild) {
    indexLogic.selectedMusic.value = mediaChild;
    Get.toNamed('/music');
  }

  void callExploreApi() async {
    var res = await RemoteService().exploreRequest();
    if (res[0] == null) {
      EasyLoading.showError(res[1]);
      return;
    }
    homeRequestModel.value = res[0];
    storyList.value = List.from(homeRequestModel.value!.data.artists);
    playList.value = List.from(homeRequestModel.value!.data.playlists);
    mediaCategory.value = List.from(homeRequestModel.value!.data.media);
  }
}
