import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/media_info_main/media_info_main_view.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bong/src/core/models/artist_detail_model.dart'
    as artistDetailModel;

class SeeAllLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  final String title = Get.arguments['title'] ?? '';
  final String id = Get.arguments['id'] ?? '0';
  late List<Tab> tabList;
  final splashLogic = Get.find<SplashLogic>();
  final indexLogic = Get.find<IndexLogic>();
  RxList<MediaChild> latestList = RxList();
  RxList<MediaChild> popularList = RxList();
  RxList<MediaChild> mustWatchList = RxList();

  late TabController tabController;
  final pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    tabList = [
      Tab(text: splashLogic.currentLanguage['latest']),
      Tab(text: splashLogic.currentLanguage['popular']),
      Tab(text: splashLogic.currentLanguage['mustWatch']),
    ];
    super.onInit();
    tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  void onReady() {
    super.onReady();
    callApi();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void callApi() async {
    RemoteService().getSeeAllMedia(id, "latest").then((res) {
      if (res[0] != null) {
        latestList.value = List.from(res[0].data);
      }
    });
    RemoteService().getSeeAllMedia(id, "popular").then((res) {
      if (res[0] != null) {
        popularList.value = List.from(res[0].data);
      }
    });
    RemoteService().getSeeAllMedia(id, "must_watch").then((res) {
      if (res[0] != null) {
        mustWatchList.value = List.from(res[0].data);
      }
    });
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

  void goToViewInfo(MediaChild item) {
    Get.back();
    Get.to(() => const MediaInfoMainPage(),
        arguments: {"media": artistDetailModel.Media.fromJson(item.toJson())});
  }

  void onPageViewChanged(int value) {
    tabController.animateTo(value);
  }

  void onTabChanged(int value) {
    pageController.jumpToPage(value);
  }

  void goToMusicPage(MediaChild mediaChild) {
    indexLogic.selectedMusic.value = mediaChild;
    Get.toNamed('/music');
  }
}
