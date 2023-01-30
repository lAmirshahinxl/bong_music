import 'package:bong/src/core/models/get_upcoming_events_model.dart';
import 'package:bong/src/screens/upcoming_events/upcoming_events_logic.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class EventsDetailLogic extends GetxController {
  late EventModel model;

  @override
  void onReady() {
    print(model.id);
    super.onReady();
  }

  void clickedOnPuchase() {
    launchUrlString(model.purchaseLink.toString());
  }
}
