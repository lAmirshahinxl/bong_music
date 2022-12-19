import 'package:bong/src/config/string_constants.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/video_ui/video_ui_logic.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoLogic extends GetxController {
  final videoUiLogic = Get.find<VideoUiLogic>();
  final indexLogic = Get.find<IndexLogic>();
  late VideoPlayerController videoPlayerController;

  Rxn<ChewieController> chewieController = Rxn();
  @override
  void onInit() {
    videoPlayerController = VideoPlayerController.network(
        '$imageBaseUrl/${videoUiLogic.currenMedia.originalSource}');
    initVideo();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    indexLogic.addToRecentlyViewed(videoUiLogic.currenMedia);
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController.value?.dispose();
    super.onClose();
  }

  Future<void> reBuild() async {
    videoPlayerController.dispose();
    chewieController.value?.dispose();
    videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    initVideo();
  }

  void initVideo() async {
    await videoPlayerController.initialize();
    chewieController.value = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
    );
  }
}
