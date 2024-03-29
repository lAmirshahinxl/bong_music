import 'package:bong/src/config/string_constants.dart';
import 'package:bong/src/core/models/artist_detail_model.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bong/src/core/models/artist_detail_model.dart' as artistdetail;

import '../../core/models/get_upcoming_events_model.dart';
import '../media_info_main/media_info_main_view.dart';

class ArtistDetailLogic extends GetxController {
  late Artist currentArtist;
  Rxn<ArtistDetailModel> artistDetailModel = Rxn();
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  Rxn<EventModel> selectedEvent = Rxn();
  RxList<PlaylistChild> playLists = RxList();
  RxList<PlaylistChild> albums = RxList();

  @override
  void onReady() {
    super.onReady();
    callArtisDetailApi();
  }

  void callArtisDetailApi() async {
    var res = await RemoteService().getArtistDetail(currentArtist.id);
    if (res[0] == null) {
      EasyLoading.showToast(res[1].toString());
      return;
    }
    artistDetailModel.value = res[0];
    albums.value = List.from(artistDetailModel.value!.data.playLists
        .where((element) => element.isAlbum == 0));
    playLists.value = List.from(artistDetailModel.value!.data.playLists
        .where((element) => element.isAlbum == 1));
  }

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
