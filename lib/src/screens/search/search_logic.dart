import 'package:bong/src/core/models/artist_detail_model.dart';
import 'package:bong/src/core/models/category_childs_model.dart';
import 'package:bong/src/core/models/detail_media_model.dart';
import 'package:bong/src/core/models/get_category_model.dart' as categoryModel;
import 'package:bong/src/core/models/get_search_model.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/models/playlist_detail_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/artist_detail/artist_detail_view.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/playlist_detail/playlist_detail_view.dart';
import 'package:bong/src/screens/video_ui/video_ui_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SearchLogic extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rxn<GetSearchModel> getSearchModel = Rxn();
  Rxn<categoryModel.GetCategoriesModel> getCategoriesModel = Rxn();
  RxList<Search> searchList = RxList();
  RxList<categoryModel.Category> categoryList = RxList();
  final indexLogic = Get.find<IndexLogic>();
  Rx<String> selectedType = "music".obs;
  Rx<String> searchText = "".obs;
  Rxn<int> selectedCategoryid = Rxn();

  @override
  void onInit() {
    callGetCategoriesApi();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    ever(
      selectedType,
      (String callback) => callSearchApi(type: callback),
    );
    ever(
      searchText,
      (String callback) =>
          callSearchApi(word: callback, type: selectedType.value),
    );
  }

  void callGetCategoriesApi() async {
    getCategoriesModel.value = null;
    var res =
        await RemoteService().getCategoreis(parentId: selectedCategoryid.value);
    if (res[0] == null) {
      EasyLoading.showToast(res[1].toString());
      return;
    }
    getCategoriesModel.value = res[0];
    categoryList.value = List.from(getCategoriesModel.value!.data);
  }

  void callSearchApi({String word = "", String type = "music"}) async {
    getSearchModel.value = null;
    var res = await RemoteService().getSearch(word, type);
    if (res[0] == null) {
      EasyLoading.showToast(res[1].toString());
      return;
    }
    getSearchModel.value = res[0];
    searchList.value = List.from(getSearchModel.value!.data);
  }

  void clickedOnItem(int index) async {
    if (selectedType.value == "music") {
      EasyLoading.show(status: "Please Wait");
      var res = await RemoteService().getMediaDetail(searchList[index].id);
      EasyLoading.dismiss();
      if (res[0] == null) {
        EasyLoading.showToast(res[1].toString());
        return;
      }
      DetailMediaModel model = res[0];
      indexLogic.selectedMusic.value = MediaChild.fromJson(model.data.toJson());
      Get.toNamed('/music');
    }
    if (selectedType.value == "musicvideo") {
      EasyLoading.show(status: "Please Wait");
      var res = await RemoteService().getMediaDetail(searchList[index].id);
      EasyLoading.dismiss();
      if (res[0] == null) {
        EasyLoading.showToast(res[1].toString());
        return;
      }
      DetailMediaModel model = res[0];
      Get.to(() => VideoUiPage(MediaChild.fromJson(model.data.toJson())),
          duration: const Duration(milliseconds: 500));
    }
    if (selectedType.value == "playlist") {
      EasyLoading.show(status: "Please Wait");
      var res = await RemoteService().playListDetail(searchList[index].id);
      EasyLoading.dismiss();
      if (res[0] == null) {
        EasyLoading.showToast(res[1].toString());
        return;
      }
      PlayListDetailModel model = res[0];
      Get.to(
          () => PlayListDeatilPage(PlaylistChild.fromJson(model.data.toJson())),
          duration: const Duration(milliseconds: 500));
    }
    if (selectedType.value == "artist") {
      EasyLoading.show(status: "Please Wait");
      var res = await RemoteService().getArtistDetail(searchList[index].id);
      EasyLoading.dismiss();
      if (res[0] == null) {
        EasyLoading.showToast(res[1].toString());
        return;
      }
      ArtistDetailModel model = res[0];
      Get.to(() => ArtistDetailPage(Artist.fromJson(model.data.toJson())),
          duration: const Duration(milliseconds: 500));
    }
  }

  void clickedONSearch() {
    if (searchController.text.isEmpty) {
      callSearchApi();
    } else {
      callSearchApi(
          word: searchController.text.toString(), type: selectedType.value);
    }
  }

  void changeSelectedType(String s) {
    selectedType.value = s;
  }

  void onSearchTextChanged() {
    searchText.value = searchController.text;
  }

  void clickedOnItemCategory(int index) async {
    EasyLoading.show(status: "Please Wait");
    selectedCategoryid.value = categoryList[index].id;
    List<categoryModel.Category> childList = await callAndChackHasChild();
    EasyLoading.dismiss();
    if (childList.isEmpty) {
      goToCategoryDetail();
    } else {
      categoryList.value = List.from(childList);
    }
  }

  Future<List<categoryModel.Category>> callAndChackHasChild() async {
    var res =
        await RemoteService().getCategoreis(parentId: selectedCategoryid.value);
    if (res[0] == null) {
      EasyLoading.showToast(res[1].toString());
      return [];
    }
    return res[0].data;
  }

  void goToCategoryDetail() async {
    EasyLoading.show(status: 'please wait');
    var res = await RemoteService()
        .getPlaylistChildCategory(selectedCategoryid.value ?? 0);
    EasyLoading.dismiss();
    if (res[0] == null) {
      EasyLoading.showToast('Error data');
      return;
    }
    CatgeoryChildsModel catgeoryChildsModel = res[0];
    // Get.to(()=> PlayListDeatilPage(PlaylistChild.fromJson(catgeoryChildsModel.data!.first.media!)))
  }
}
