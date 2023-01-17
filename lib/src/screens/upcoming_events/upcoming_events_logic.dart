import 'package:bong/src/core/models/get_upcoming_events_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../core/services/services.dart';
import '../splash/splash_logic.dart';

class UpcomingEventsLogic extends GetxController {
  final splashLogic = Get.find<SplashLogic>();
  RxList<EventModel> eventList = RxList();
  Rxn<GetUpcomingEventsModel> getUpcomingEventModel = Rxn();
  Rxn<EventModel> selectedEvent = Rxn();

  @override
  void onInit() {
    callApi();
    super.onInit();
  }

  void callApi() async {
    var res = await RemoteService().getUpcomingEvents();
    if (res[0] == null) {
      EasyLoading.showToast(res[1].toString());
      return;
    }
    getUpcomingEventModel.value = res[0];
    eventList.value = List.from(getUpcomingEventModel.value!.data);
  }
}
