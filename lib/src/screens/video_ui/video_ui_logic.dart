import 'dart:io';
import 'package:bong/src/core/models/artist_detail_model.dart'
    as artistDetailModel;
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/music/music_view.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:bong/src/screens/video/video_logic.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../config/string_constants.dart';
import '../../core/services/services.dart';
import '../../utils/utils.dart';
import 'package:bong/src/core/models/detail_media_model.dart'
    as mediaDetailModel;

import '../media_info_main/media_info_main_view.dart';

class VideoUiLogic extends GetxController {
  late MediaChild currenMedia;
  File? offlineFile;
  Rx<bool> isFavorite = false.obs;
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  RxList<artistDetailModel.Story> storiesList = RxList();
  RxList<mediaDetailModel.Data> upnextList = RxList();
  Rxn<mediaDetailModel.DetailMediaModel> detailMediaModel = Rxn();

  @override
  void onReady() {
    super.onReady();
    if (currenMedia.isFavourite) {
      isFavorite.value = true;
    } else {
      isFavorite.value = true;
    }
    callDetailApi();
  }

  @override
  void onClose() {
    try {
      final videoLogic = Get.find<VideoLogic>();
      videoLogic.videoPlayerController.dispose();
      videoLogic.chewieController.value?.dispose();
    } catch (e) {}
    super.onClose();
  }

  void downloadVideo() async {
    EasyLoading.show(status: "Downloading");
    var fileInfo = await DefaultCacheManager().getFileFromCache(
        "$imageBaseUrlWithoutSlash${currenMedia.originalSource}");
    if (fileInfo == null) {
      var file = await DefaultCacheManager().getSingleFile(
          "$imageBaseUrlWithoutSlash${currenMedia.originalSource}");
      indexLogic.addOfflineMusic(currenMedia);
      EasyLoading.showToast('File Added To Your PlayList');
    } else {
      EasyLoading.showToast('File Already Added To Playlist');
    }
  }

  void addToFavorite() async {
    if (!GetStorage().hasData('token')) {
      EasyLoading.showToast('please login first');
      return;
    }
    EasyLoading.show(status: "Please Wait");
    var res = await RemoteService().toggleFavorite(currenMedia.id, 'media');
    EasyLoading.showSuccess("SuccessFul");
    isFavorite.value = !isFavorite.value;
  }

  void callDetailApi() async {
    var res = await RemoteService().getMediaDetail(currenMedia.id);
    EasyLoading.dismiss();
    if (res[0] == null) {
      EasyLoading.showToast("Error Data");
      return;
    }

    detailMediaModel.value = res[0];
    storiesList.clear();
    upnextList.clear();
    storiesList.value = List.from(res[0].data.stories);
    upnextList.value = List.from(res[0].data.upNext);
    Get.find<VideoLogic>().reBuild();
  }

  void clickedOnItemUpnext(int index) {
    if (!upnextList[index].originalSource.contains('.mp4')) {
      indexLogic.selectedMusic.value =
          MediaChild.fromJson(upnextList[index].toJson());
      try {
        final videoLogic = Get.find<VideoLogic>();
        videoLogic.videoPlayerController.pause();
      } catch (e) {}
      Get.to(() => MusicPage());
    } else {
      currenMedia = MediaChild.fromJson(upnextList[index].toJson());
      detailMediaModel.value = null;
      callDetailApi();
    }
  }

  void goToViewInfo() {
    Get.back();
    Get.toNamed('/media_info');
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

  void goToViewInfoUpnext(mediaDetailModel.Data upnextItem) {
    Get.back();
    Get.to(() => const MediaInfoMainPage(), arguments: {
      "media": artistDetailModel.Media.fromJson(upnextItem.toJson())
    });
  }
}
