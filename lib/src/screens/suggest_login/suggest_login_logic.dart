import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class SuggestLoginLogic extends GetxController {
  VideoPlayerController? controller;

  @override
  void onInit() {
    controller = VideoPlayerController.asset('assets/icons/video.mp4')
      ..initialize().then((_) {
        super.onReady();
      });
    controller!.play();
    controller!.setLooping(true);
    super.onInit();
    GetStorage().write('one', true);
  }
}
