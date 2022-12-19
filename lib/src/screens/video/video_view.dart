import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:bong/src/screens/video/video_logic.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final logic = Get.put(VideoLogic());

  @override
  void dispose() {
    Get.delete<VideoLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSwitcherFlip.flipX(
        duration: const Duration(milliseconds: 500),
        child: logic.chewieController.value == null
            ? Container(
                color: Colors.black,
                width: Get.width,
                height: double.infinity,
                child: Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xffFFD700),
                    size: 25,
                  ),
                ),
              )
            : Container(
                width: Get.width,
                height: Get.height,
                color: Get.isDarkMode ? Colors.black : Colors.white,
                child: Chewie(controller: logic.chewieController.value!),
              ),
      );
    });
  }
}
