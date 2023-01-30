import 'dart:math';

import 'package:bong/src/core/models/detail_media_model.dart'
    as mediaDetailModel;
import 'package:bong/src/core/models/artist_detail_model.dart'
    as artistDetailModel;
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../../config/string_constants.dart';
import '../../utils/utils.dart';
import '../login/login_view.dart';
import '../media_info_main/media_info_main_view.dart';

class MusicLogic extends GetxController {
  Rx<bool> showAnimation = false.obs;
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();

  bool fromBottom = false;

  @override
  void onReady() {
    super.onReady();
    if (!fromBottom) playMusic();
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        showAnimation.value = true;
      },
    );
    callDetailApi();
  }

  @override
  void onClose() {
    if (!indexLogic.audioPlayer.playing) {
      indexLogic.audioPlayer.stop();
    }
    super.onClose();
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
      if (indexLogic.totalDuration.value <=
              (event + const Duration(seconds: 1)) &&
          indexLogic.shuffle.value) {
        clickedOnNextRandom();
      }
    });
    indexLogic.audioPlayer.playerStateStream.listen((PlayerState event) {
      indexLogic.isPlaying.value = event.playing;
      if (!event.playing &&
          indexLogic.loopModeList[indexLogic.selectedLoopModeIndex.value] ==
              LoopMode.all) {
        clickedOnNext();
      }
    });
    indexLogic.audioPlayer.loopModeStream.listen((LoopMode event) {});
    indexLogic.audioPlayer.setAudioSource(AudioSource.uri(
      Uri.parse(
          "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.originalSource}"),
      tag: MediaItem(
        id: indexLogic.selectedMusic.value!.id.toString(),
        album: "",
        title: indexLogic.selectedMusic.value!.title.en.toString(),
        artUri: Uri.parse(
            "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.imageUrl}"),
      ),
    ));

    indexLogic.audioPlayer.play();
  }

  void seekTo(Duration duration) {
    indexLogic.audioPlayer.seek(duration);
  }

  void changeLoopMode() {
    if (indexLogic.selectedLoopModeIndex.value == 2) {
      indexLogic.selectedLoopModeIndex.value = 0;
    } else {
      indexLogic.selectedLoopModeIndex.value++;
    }
    indexLogic.audioPlayer.setLoopMode(
        indexLogic.loopModeList[indexLogic.selectedLoopModeIndex.value]);
  }

  void callDetailApi() async {
    var res = await RemoteService()
        .getMediaDetail(indexLogic.selectedMusic.value!.id);
    if (res[0] == null) {
      EasyLoading.showToast("Error Data");
      return;
    }

    indexLogic.detailMediaModel.value = res[0];
    indexLogic.storiesList.clear();
    indexLogic.upnextList.clear();
    indexLogic.storiesList.value = List.from(res[0].data.stories);
    indexLogic.upnextList.value = List.from(res[0].data.upNext);

    await RemoteService().incrasePlay(indexLogic.selectedMusic.value!.id);
  }

  void clickedOnItemUpnext(int index) {
    indexLogic.selectedMusic.value =
        MediaChild.fromJson(indexLogic.upnextList[index].toJson());
    playMusic();
    callDetailApi();
  }

  void addToFavorite() async {
    if (!GetStorage().hasData('token')) {
      EasyLoading.showToast('please login first');
      Get.to(() => LoginPage(), duration: const Duration(seconds: 1));
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

  void addToFavoriteUpnext(mediaDetailModel.Data upnextItem) async {
    if (!GetStorage().hasData('token')) {
      EasyLoading.showToast('please login first');
      return;
    }
    EasyLoading.show(status: "Please Wait");
    await RemoteService().toggleFavorite(upnextItem.id, "media");
    EasyLoading.showToast("SuccessFul");
    upnextItem.isFavourite = !upnextItem.isFavourite;
  }

  void clickedOnNext() {
    print(indexLogic.upnextIndex);
    if (indexLogic.upnextIndex + 1 == indexLogic.upnextList.length) {
      indexLogic.upnextIndex = 0;
      indexLogic.selectedMusic.value = MediaChild.fromJson(
          indexLogic.upnextList[indexLogic.upnextIndex].toJson());
      playMusic();
      callDetailApi();
      return;
    }
    indexLogic.upnextIndex++;
    indexLogic.selectedMusic.value = MediaChild.fromJson(
        indexLogic.upnextList[indexLogic.upnextIndex].toJson());
    playMusic();
    callDetailApi();
  }

  void clickedOnPrevi() {
    print(indexLogic.upnextIndex);
    if (indexLogic.upnextIndex == 0) {
      return;
    }
    indexLogic.upnextIndex--;
    indexLogic.selectedMusic.value = MediaChild.fromJson(
        indexLogic.upnextList[indexLogic.upnextIndex].toJson());
    playMusic();
    callDetailApi();
  }

  void goToViewInfo() {
    Get.back();
    Get.toNamed('/media_info');
  }

  void downloadMusic() async {
    EasyLoading.show(status: "Downloading");
    var fileInfo = await DefaultCacheManager().getFileFromCache(
        "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.originalSource}");
    if (fileInfo == null) {
      var file = await DefaultCacheManager().getSingleFile(
          "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.originalSource}");
      indexLogic.addOfflineMusic(indexLogic.selectedMusic.value);
      EasyLoading.showToast('File Added To Your PlayList');
    } else {
      EasyLoading.showToast('File Already Added To Playlist');
    }

    // String downloadPath = await getDownloadPath() ?? '/';
    // await FlutterDownloader.enqueue(
    //     url:
    //         "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.originalSource}",
    //     headers: {},
    //     savedDir: downloadPath,
    //     showNotification: true,
    //     openFileFromNotification: true,
    //     saveInPublicStorage: true);
  }

  void goToViewInfoUpnext(mediaDetailModel.Data upnextItem) {
    Get.back();
    Get.to(() => const MediaInfoMainPage(), arguments: {
      "media": artistDetailModel.Media.fromJson(upnextItem.toJson())
    });
  }

  void changeSuffle() {
    indexLogic.shuffle.value = !indexLogic.shuffle.value;
  }

  void clickedOnNextRandom() {
    int randomInt = Random().nextInt(indexLogic.upnextList.length);
    indexLogic.upnextIndex = randomInt;
    indexLogic.selectedMusic.value =
        MediaChild.fromJson(indexLogic.upnextList[randomInt].toJson());
    playMusic();
    callDetailApi();
  }
}
