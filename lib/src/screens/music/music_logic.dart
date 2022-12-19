import 'package:bong/src/core/models/artist_detail_model.dart'
    as artistDetailModel;
import 'package:bong/src/core/models/detail_media_model.dart'
    as mediaDetailModel;
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../config/string_constants.dart';

class MusicLogic extends GetxController {
  Rx<bool> showAnimation = false.obs;
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  RxList<artistDetailModel.Story> storiesList = RxList();
  RxList<mediaDetailModel.Data> upnextList = RxList();

  @override
  void onInit() {
    super.onInit();
    if (!indexLogic.audioPlayer.playing) playMusic();
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        showAnimation.value = true;
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    callDetailApi();
  }

  void back() => Get.back();

  void playMusic() async {
    indexLogic.totalDuration.value = indexLogic.selectedMusic.value == null
        ? const Duration(seconds: 0)
        : await indexLogic.audioPlayer.setUrl(
                "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.originalSource}") ??
            const Duration(seconds: 0);
    indexLogic.audioPlayer.bufferedPositionStream.listen((Duration event) {
      indexLogic.buffredDuration.value = event;
    });
    indexLogic.audioPlayer.positionStream.listen((Duration event) {
      indexLogic.currentDuration.value = event;
    });
    indexLogic.audioPlayer.playerStateStream.listen((PlayerState event) {
      indexLogic.isPlaying.value = event.playing;
    });
    indexLogic.audioPlayer.loopModeStream.listen((LoopMode event) {
      if (event == LoopMode.off) {
        indexLogic.loopMode.value = false;
      } else {
        indexLogic.loopMode.value = true;
      }
    });
    indexLogic.audioPlayer.play();
  }

  void seekTo(Duration duration) {
    indexLogic.audioPlayer.seek(duration);
  }

  void changeLoopMode() {
    if (indexLogic.loopMode.value) {
      indexLogic.audioPlayer.setLoopMode(LoopMode.off);
    } else {
      indexLogic.audioPlayer.setLoopMode(LoopMode.one);
    }
  }

  void callDetailApi() async {
    var res = await RemoteService()
        .getMediaDetail(indexLogic.selectedMusic.value!.id);
    if (res[0] == null) {
      EasyLoading.showToast("Error Data");
      return;
    }
    storiesList.clear();
    upnextList.clear();
    storiesList.value = List.from(res[0].data.stories);
    upnextList.value = List.from(res[0].data.upNext);
  }

  void clickedOnItemUpnext(int index) {
    indexLogic.selectedMusic.value =
        MediaChild.fromJson(upnextList[index].toJson());
    playMusic();
  }
}
