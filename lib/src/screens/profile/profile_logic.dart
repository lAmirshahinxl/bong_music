import 'package:bong/src/screens/favorites/favorites_view.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/latest_artist/latest_artist_view.dart';
import 'package:bong/src/screens/login/login_view.dart';
import 'package:bong/src/screens/offline_playlist/offline_playlist_view.dart';
import 'package:bong/src/screens/setting/setting_view.dart';
import 'package:bong/src/screens/viewed_music/viewed_music_view.dart';
import 'package:bong/src/screens/viewed_playlist/viewed_playlist_view.dart';
import 'package:bong/src/screens/viewed_podcast/viewed_podcast_view.dart';
import 'package:bong/src/screens/viewed_video/viewed_video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../splash/splash_logic.dart';

class ProfileLogic extends GetxController {
  RxList<Map> tabListStatics = RxList();
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();

  @override
  void onInit() {
    settabListData();
    ever(
      splashLogic.currentLanguage,
      (callback) => settabListData(),
    );
    super.onInit();
  }

  void settabListData() {
    tabListStatics.clear();
    tabListStatics.addAll([
      {
        "name": splashLogic.currentLanguage['playList'],
        "icon": Icons.music_note_rounded
      },
      {
        "name": splashLogic.currentLanguage['songs'],
        "icon": Icons.video_collection_rounded
      },
      {
        "name": splashLogic.currentLanguage['artists'],
        "icon": Icons.data_usage_sharp
      },
      {
        "name": splashLogic.currentLanguage['podcasts'],
        "icon": Icons.podcasts_rounded
      },
      {
        "name": splashLogic.currentLanguage['videos'],
        "icon": Icons.video_camera_front_rounded
      },
      {
        "name": splashLogic.currentLanguage['favorite'],
        "icon": Icons.favorite_border_rounded
      },
      {
        "name": splashLogic.currentLanguage['setting'],
        "icon": Icons.settings_rounded
      },
      {
        "name": splashLogic.currentLanguage['myPlaylist'],
        "icon": Icons.play_for_work_rounded
      },
      {
        "name": GetStorage().hasData('token')
            ? splashLogic.currentLanguage['logout']
            : splashLogic.currentLanguage['login'],
        "icon": Icons.login_rounded
      }
    ]);
  }

  void goToSettingPage() {
    Get.to(() => const SettingPage(), duration: const Duration(seconds: 1));
  }

  void goToLoginPage() {
    if (GetStorage().hasData('token')) {
      GetStorage().remove('token');
      GetStorage().remove('email');
      GetStorage().remove('one');
      tabListStatics.last = {
        "name": GetStorage().hasData('token')
            ? splashLogic.currentLanguage['logout']
            : splashLogic.currentLanguage['login'],
        "icon": Icons.login_rounded
      };
      EasyLoading.showToast("Logout Successful");
    } else {
      Get.to(() => LoginPage(), duration: const Duration(seconds: 1));
    }
  }

  void clickedOnRecently(int index) {
    if (indexLogic.recentlyPlayed[index].originalSource.contains('.mp4')) {
    } else {
      indexLogic.selectedMusic.value = indexLogic.recentlyPlayed[index];
      Get.toNamed('/music');
    }
  }

  void goToLatestArtist() {
    Get.to(() => const LatestArtistPage(),
        duration: const Duration(seconds: 1));
  }

  void goToViewedPlaylist() {
    Get.to(() => const ViewedPlaylistPage(),
        duration: const Duration(seconds: 1));
  }

  void goToViewedMusic() {
    Get.to(() => const ViewedMusicPage(), duration: const Duration(seconds: 1));
  }

  void goToPodcast() {
    Get.to(() => const ViewedPodcastPage(),
        duration: const Duration(seconds: 1));
  }

  void goToViewedVideo() {
    Get.to(() => const ViewedVideoPage(), duration: const Duration(seconds: 1));
  }

  void goToFavoritePage() {
    Get.to(() => const FavoritsPage(), duration: const Duration(seconds: 1));
  }

  void goToOfflineMusic() {
    Get.to(() => const OfflinePLaylistPage(),
        duration: const Duration(seconds: 1));
  }
}
