import 'package:bong/src/core/models/detail_media_model.dart';
import 'package:bong/src/core/models/get_search_model.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SearchLogic extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rxn<GetSearchModel> getSearchModel = Rxn();
  RxList<Search> searchList = RxList();
  final indexLogic = Get.find<IndexLogic>();
  Rx<String> selectedType = "music".obs;

  @override
  void onInit() {
    callSearchApi();
    super.onInit();
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
  }

  void clickedONSearch() {
    if (searchController.text.isEmpty) {
      callSearchApi();
    } else {
      callSearchApi(
          word: searchController.text.toString(), type: selectedType.value);
    }
  }
}
