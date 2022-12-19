import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
