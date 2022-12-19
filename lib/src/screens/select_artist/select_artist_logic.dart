import 'package:bong/src/core/models/get_artist_model.dart';
import 'package:bong/src/core/models/get_category_model.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

enum CurrentState { artist, category }

class SelectArtistLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();
  PageController pageController = PageController();
  RxList<Artist> artistList = RxList();
  RxList<int> selectedArtistListIndex = RxList();
  RxList<Category> categoryList = RxList();
  RxList<int> selectedCategoryListIndex = RxList();
  Rx<CurrentState> currentState = CurrentState.artist.obs;

  @override
  void onReady() {
    super.onReady();
    callGetArtistsModel();
    callGetCategoryList();
  }

  void callGetArtistsModel() async {
    var res = await RemoteService().getArtists();
    if (res[0] == null) {
      EasyLoading.showToast("Error, Check Your Connection");
      callGetArtistsModel();
      return;
    }
    artistList.value = List.from(res[0].data);
  }

  void callGetCategoryList() async {
    var res = await RemoteService().getCategoreis();
    if (res[0] == null) {
      EasyLoading.showToast("Error, Check Your Connection");
      callGetCategoryList();
      return;
    }
    categoryList.value = List.from(res[0].data);
  }

  void removeSelectedArtist(int index) {
    if (selectedArtistListIndex.contains(index)) {
      selectedArtistListIndex.removeWhere((element) => element == index);
    }
  }

  void addSelectedArtist(int index) {
    if (!selectedArtistListIndex.contains(index)) {
      selectedArtistListIndex.add(index);
    }
  }

  void clickedOnNext() async {
    if (currentState.value == CurrentState.artist) {
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    } else {
      EasyLoading.show(status: 'please wait');
      await callAddToFavoriteApi();
      EasyLoading.showToast('Successful.');
      Get.back();
    }
  }

  void removeSelectedCategory(int index) {
    if (selectedCategoryListIndex.contains(index)) {
      selectedCategoryListIndex.removeWhere((element) => element == index);
    }
  }

  void addSelectedCategory(int index) {
    if (!selectedCategoryListIndex.contains(index)) {
      selectedCategoryListIndex.add(index);
    }
  }

  void onBackPressed() {
    if (currentState.value == CurrentState.artist) {
      Get.back();
    } else {
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

  void onPageviewChanged(int value) {
    currentState.value =
        value == 0 ? CurrentState.artist : CurrentState.category;
  }

  Future<void> callAddToFavoriteApi() async {
    for (var index in selectedArtistListIndex) {
      RemoteService().toggleFavorite(artistList[index].id, "artist");
    }
    for (var index in selectedCategoryListIndex) {
      RemoteService().toggleFavorite(categoryList[index].id, "category");
    }
  }
}
