import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:bong/src/widgets/ask_for_login_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';

class IndexLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();

  var pageController = PageController(initialPage: 0);
  Rx<int> selectedIndex = 0.obs;
  Rx<String> headerText = 'bong music'.obs;
  final audioPlayer = AudioPlayer();
  Rxn<MediaChild> selectedMusic = Rxn();
  Rx<bool> isPlaying = false.obs;
  Rx<Duration> currentDuration = const Duration(seconds: 0).obs;
  Rx<Duration> totalDuration = const Duration(seconds: 0).obs;
  Rx<Duration> buffredDuration = const Duration(seconds: 0).obs;
  RxList<MediaChild> recentlyPlayed = RxList();
  RxList<MediaChild> offlineMusicUrlList = RxList();
  List<LoopMode> loopModeList = [LoopMode.off, LoopMode.all, LoopMode.one];
  Rx<int> selectedLoopModeIndex = 0.obs;

  @override
  void onInit() {
    ever(
      splashLogic.currentLanguage,
      (callback) => headerText.value = splashLogic.currentLanguage['appName'],
    );
    ever(
      selectedMusic,
      (callback) => addToRecentlyViewed(callback),
    );
    getRecentlyPlayed();
    getOfflineMusics();
    initListener();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    showSuggestLogin();
  }

  void initListener() async {
    ever(
      selectedIndex,
      (int callback) {
        changeTabPage(callback);
      },
    );
    audioPlayer.bufferedPositionStream.listen((Duration event) {
      buffredDuration.value = event;
    });
    audioPlayer.positionStream.listen((Duration event) {
      currentDuration.value = event;
    });
    audioPlayer.playerStateStream.listen((PlayerState event) {
      isPlaying.value = event.playing;
    });
    audioPlayer.loopModeStream.listen((LoopMode event) {
      print('loop changed : ${event.toString()}');
    });
  }

  void playOrPause() {
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      // AudioSource.uri(
      //   Uri.parse(selectedUrl.value),
      //   tag: const MediaItem(
      //     id: '1',
      //     album: "Todays Top Hits",
      //     title: "My Music",
      //   ),
      // );
      audioPlayer.play();
    }
  }

  void changeTabPage(int page) {
    pageController.jumpToPage(page);
    switch (page) {
      case 0:
        headerText.value = splashLogic.currentLanguage['appName'];
        break;
      case 1:
        headerText.value = splashLogic.currentLanguage['explore'];
        break;
      case 2:
        headerText.value = splashLogic.currentLanguage['search'];
        break;
      case 3:
        headerText.value = splashLogic.currentLanguage['profile'];
        break;
      default:
        headerText.value = splashLogic.currentLanguage['appName'];
    }
  }

  void onPageChanged(int value) {
    selectedIndex.value = value;
  }

  void seekTo(Duration duration) {
    audioPlayer.seek(duration);
  }

  void addToRecentlyViewed(MediaChild? mediaChild) {
    if (mediaChild == null) return;
    if (recentlyPlayed
            .firstWhereOrNull((element) => element.id == mediaChild.id) !=
        null) return;
    recentlyPlayed.add(mediaChild);
    GetStorage().write('recently', recentlyPlayed.toJson());
    getRecentlyPlayed();
  }

  void addOfflineMusic(MediaChild? mediaChild) {
    if (mediaChild == null) return;
    if (offlineMusicUrlList
            .firstWhereOrNull((element) => element.id == mediaChild.id) !=
        null) return;
    offlineMusicUrlList.add(mediaChild);
    GetStorage().write('offlineMusic', offlineMusicUrlList.toJson());
    getOfflineMusics();
  }

  void getRecentlyPlayed() {
    try {
      recentlyPlayed.value = List.from(GetStorage().read('recently') == null
          ? List.from([])
          : List<MediaChild>.from(GetStorage()
              .read('recently')
              .map((x) => MediaChild.fromJson(x))));
    } catch (e) {}
    print("recentlyPlayed.length : ${recentlyPlayed.length}");
  }

  void getOfflineMusics() {
    try {
      offlineMusicUrlList.value = GetStorage().hasData('offlineMusic')
          ? List<MediaChild>.from(GetStorage()
              .read('offlineMusic')
              .map((x) => MediaChild.fromJson(x)))
          : List.from([]);
    } catch (e) {}
  }

  void showSuggestLogin() {
    if (!GetStorage().hasData('token') && !GetStorage().hasData('one')) {
      Get.toNamed('/suggest');
    } else if (!GetStorage().hasData('token')) {
      Get.bottomSheet(const AskForLoginBottomsheet(),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          isDismissible: false);
    }
  }
}
