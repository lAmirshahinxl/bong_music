import 'dart:ui';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:animations/animations.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bong/src/config/color_constants.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/music/music_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../config/string_constants.dart';

class BottomPlayerWidget extends StatefulWidget {
  const BottomPlayerWidget({super.key});

  @override
  State<BottomPlayerWidget> createState() => _BottomPlayerWidgetState();
}

class _BottomPlayerWidgetState extends State<BottomPlayerWidget> {
  final indexLogic = Get.find<IndexLogic>();

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      tappable: true,
      closedColor: Colors.transparent,
      closedElevation: 0,
      openElevation: 0,
      transitionDuration: const Duration(milliseconds: 400),
      closedBuilder: (context, action) {
        return Obx(
          () => AnimatedSizeAndFade.showHide(
              fadeDuration: const Duration(milliseconds: 500),
              sizeDuration: const Duration(milliseconds: 500),
              show: indexLogic.isPlaying.value,
              child: indexLogic.selectedMusic.value == null
                  ? const SizedBox()
                  : Container(
                      height: 90,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                          image: NetworkImage(
                              "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.imageUrl}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorConstants.cardbackground
                                      .withOpacity(0.5)),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, top: 5, bottom: 5),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        indexLogic.selectedMusic.value == null
                                            ? ""
                                            : indexLogic
                                                .selectedMusic.value!.title.en
                                                .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: ColorConstants.gold),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                indexLogic.audioPlayer.stop();
                                              },
                                              icon: Icon(
                                                Icons.stop_rounded,
                                                size: 35,
                                                color: ColorConstants.gold,
                                              )),
                                        ],
                                      )
                                    ],
                                  )),
                                  StreamBuilder(
                                    stream:
                                        indexLogic.audioPlayer.positionStream,
                                    builder: (context,
                                        AsyncSnapshot<Duration?> position) {
                                      return StreamBuilder(
                                        stream: indexLogic
                                            .audioPlayer.bufferedPositionStream,
                                        builder: (context,
                                                AsyncSnapshot<Duration?>
                                                    buffred) =>
                                            StreamBuilder(
                                                stream: indexLogic
                                                    .audioPlayer.durationStream,
                                                builder:
                                                    (context, totalDuration) {
                                                  return ProgressBar(
                                                    progress: position.data ??
                                                        const Duration(
                                                            seconds: 1),
                                                    buffered: buffred.data ??
                                                        const Duration(
                                                            seconds: 1),
                                                    total: totalDuration.data ??
                                                        const Duration(
                                                            seconds: 1),
                                                    progressBarColor:
                                                        ColorConstants.gold,
                                                    baseBarColor: Colors.black
                                                        .withOpacity(0.2),
                                                    thumbColor:
                                                        ColorConstants.gold,
                                                    thumbGlowColor:
                                                        ColorConstants.gold,
                                                    bufferedBarColor: Colors
                                                        .black
                                                        .withOpacity(0.2),
                                                    onSeek: (duration) {
                                                      indexLogic
                                                          .seekTo(duration);
                                                    },
                                                    timeLabelTextStyle: Theme
                                                            .of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                ColorConstants
                                                                    .gold),
                                                  );
                                                }),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
        );
      },
      openBuilder: (context, action) => MusicPage(
        fromBottom: true,
      ),
    );
  }
}
