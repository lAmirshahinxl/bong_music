import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
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
  Rx<bool> loopMode = false.obs;
  Rx<Duration> currentDuration = const Duration(seconds: 0).obs;
  Rx<Duration> totalDuration = const Duration(seconds: 0).obs;
  Rx<Duration> buffredDuration = const Duration(seconds: 0).obs;
  RxList<MediaChild> recentlyPlayed = RxList();

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
    initListener();
    super.onInit();
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
      if (event == LoopMode.off) {
        loopMode.value = false;
      } else {
        loopMode.value = true;
      }
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

  void getRecentlyPlayed() {
    recentlyPlayed.value = List.from(GetStorage().read('recently') == null
        ? List.from([])
        : List<MediaChild>.from(
            GetStorage().read('recently').map((x) => MediaChild.fromJson(x))));
    print("recentlyPlayed.length : ${recentlyPlayed.length}");
  }
}
