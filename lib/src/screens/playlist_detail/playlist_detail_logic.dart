import 'package:bong/src/core/models/playlist_detail_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../config/string_constants.dart';
import '../../core/models/home_requests_model.dart';

class PlayListDetailLogic extends GetxController {
  late void Function({Object? returnValue}) action;
  late Rx<PlaylistChild> currenPlayList;
  final indexLogic = Get.find<IndexLogic>();
  Rxn<PlayListDetailModel> detailModel = Rxn();

  @override
  void onReady() {
    super.onReady();
    callPlayListDetailApi();
  }

  void callPlayListDetailApi() async {
    var res = await RemoteService().playListDetail(currenPlayList.value.id);
    if (res[0] == null) {
      EasyLoading.showError(res[1].toString());
      return;
    }
    detailModel.value = res[0];
  }

  void addToFavorite() async {
    if (!GetStorage().hasData('token')) {
      EasyLoading.showToast('please login first');
      return;
    }
    EasyLoading.show(status: "Please Wait");
    var res = await RemoteService()
        .toggleFavorite(currenPlayList.value.id, 'playlist');
    EasyLoading.showSuccess("SuccessFul");
    currenPlayList.value.isLiked = !currenPlayList.value.isLiked;
    currenPlayList.refresh();
  }

  void downloadPlayList() async {
    final taskId = await FlutterDownloader.enqueue(
      url:
          "$imageBaseUrlWithoutSlash${detailModel.value!.data.media.first.originalSource}",
      headers: {},
      savedDir: '/',
      showNotification: true,
      openFileFromNotification: true,
    );
    await FlutterDownloader.open(taskId: taskId!);
  }

  void goToMusicPage(MediaChild mediaChild) {
    indexLogic.selectedMusic.value = mediaChild;
    Get.toNamed('/music');
  }
}
