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
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../config/string_constants.dart';
import '../core/models/home_requests_model.dart';
import '../core/services/services.dart';

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
              show: indexLogic.selectedMusic.value != null,
              child: indexLogic.selectedMusic.value == null
                  ? const SizedBox()
                  : GestureDetector(
                      // onHorizontalDragEnd: (DragEndDetails details) {
                      //   if (details.primaryVelocity! > 0) {
                      //   } else if (details.primaryVelocity! < 0) {}
                      // },
                      onHorizontalDragUpdate: (details) {
                        // Note: Sensitivity is integer used when you don't want to mess up vertical drag
                        int sensitivity = 30;
                        if (details.delta.dx > sensitivity) {
                          print('right');
                          clickedOnNext();
                        } else if (details.delta.dx < -sensitivity) {
                          print('left');
                          clickedOnPrevi();
                        }
                      },
                      child: Container(
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
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            children: [
                                              /*StreamBuilder(
                                                  stream: indexLogic
                                                      .audioPlayer.loopModeStream,
                                                  builder: (context,
                                                      AsyncSnapshot<LoopMode>
                                                          snapshot) {
                                                    return IconButton(
                                                      onPressed: changeLoopMode,
                                                      icon: Icon(
                                                        snapshot.data ==
                                                                LoopMode.one
                                                            ? Icons
                                                                .repeat_one_rounded
                                                            : Icons
                                                                .repeat_rounded,
                                                        size: 25,
                                                        color: snapshot.data ==
                                                                LoopMode.all
                                                            ? ColorConstants.gold
                                                            : snapshot.data ==
                                                                    LoopMode.off
                                                                ? Colors.white
                                                                : ColorConstants
                                                                    .gold,
                                                      ),
                                                    );
                                                  }),*/
                                              // IconButton(
                                              //     onPressed: () {
                                              //       clickedOnPrevi();
                                              //     },
                                              //     icon: const RotatedBox(
                                              //       quarterTurns: 270,
                                              //       child: Icon(
                                              //         Icons
                                              //             .fast_forward_rounded,
                                              //         size: 25,
                                              //         color: Colors.white,
                                              //       ),
                                              //     )),
                                              IconButton(
                                                  onPressed: () {
                                                    indexLogic.audioPlayer
                                                        .stop();
                                                    indexLogic.selectedMusic
                                                        .value = null;
                                                  },
                                                  icon: Icon(
                                                    Icons.stop_rounded,
                                                    size: 35,
                                                    color: ColorConstants.gold,
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    indexLogic.playOrPause();
                                                  },
                                                  icon: Icon(
                                                    indexLogic.isPlaying.value
                                                        ? Icons.pause_rounded
                                                        : Icons
                                                            .play_arrow_rounded,
                                                    size: 35,
                                                    color: Colors.white,
                                                  )),
                                              // IconButton(
                                              //     onPressed: () {
                                              //       clickedOnNext();
                                              //     },
                                              //     icon: const Icon(
                                              //       Icons.fast_forward_rounded,
                                              //       size: 25,
                                              //       color: Colors.white,
                                              //     )),
                                              // IconButton(
                                              //     onPressed: () {
                                              //       downloadMusic();
                                              //     },
                                              //     icon: const Icon(
                                              //       Icons.download_rounded,
                                              //       size: 25,
                                              //       color: Colors.white,
                                              //     ))
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                    StreamBuilder(
                                      stream:
                                          indexLogic.audioPlayer.positionStream,
                                      builder: (context,
                                          AsyncSnapshot<Duration?> position) {
                                        return StreamBuilder(
                                          stream: indexLogic.audioPlayer
                                              .bufferedPositionStream,
                                          builder: (context,
                                                  AsyncSnapshot<Duration?>
                                                      buffred) =>
                                              StreamBuilder(
                                                  stream: indexLogic.audioPlayer
                                                      .durationStream,
                                                  builder:
                                                      (context, totalDuration) {
                                                    return ProgressBar(
                                                      progress: position.data ??
                                                          const Duration(
                                                              seconds: 1),
                                                      buffered: buffred.data ??
                                                          const Duration(
                                                              seconds: 1),
                                                      total:
                                                          totalDuration.data ??
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
                      ),
                    )),
        );
      },
      openBuilder: (context, action) => MusicPage(
        fromBottom: true,
      ),
    );
  }

  void clickedOnNext() {
    print(indexLogic.upnextIndex);
    if (indexLogic.upnextIndex + 1 == indexLogic.upnextList.length) {
      indexLogic.upnextIndex = 0;
      indexLogic.selectedMusic.value = MediaChild.fromJson(
          indexLogic.upnextList[indexLogic.upnextIndex].toJson());
      playMusic();
      callDetailApi();
      return;
    }
    indexLogic.upnextIndex++;
    indexLogic.selectedMusic.value = MediaChild.fromJson(
        indexLogic.upnextList[indexLogic.upnextIndex].toJson());
    playMusic();
    callDetailApi();
  }

  void clickedOnPrevi() {
    print(indexLogic.upnextIndex);
    if (indexLogic.upnextIndex == 0) {
      return;
    }
    indexLogic.upnextIndex--;
    indexLogic.selectedMusic.value = MediaChild.fromJson(
        indexLogic.upnextList[indexLogic.upnextIndex].toJson());
    playMusic();
    callDetailApi();
  }

  void callDetailApi() async {
    var res = await RemoteService()
        .getMediaDetail(indexLogic.selectedMusic.value!.id);
    if (res[0] == null) {
      EasyLoading.showToast("Error Data");
      return;
    }

    indexLogic.detailMediaModel.value = res[0];
    indexLogic.storiesList.clear();
    indexLogic.upnextList.clear();
    indexLogic.storiesList.value = List.from(res[0].data.stories);
    indexLogic.upnextList.value = List.from(res[0].data.upNext);

    await RemoteService().incrasePlay(indexLogic.selectedMusic.value!.id);
  }

  void playMusic() async {
    indexLogic.totalDuration.value = indexLogic.selectedMusic.value == null
        ? const Duration(seconds: 0)
        : await indexLogic.audioPlayer.setUrl(
                "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.originalSource}") ??
            const Duration(seconds: 0);
    indexLogic.audioPlayer.bufferedPositionStream.listen((Duration event) {
      indexLogic.buffredDuration.value = event;
    });
    indexLogic.audioPlayer.positionStream.listen((Duration event) {
      indexLogic.currentDuration.value = event;
    });
    indexLogic.audioPlayer.playerStateStream.listen((PlayerState event) {
      indexLogic.isPlaying.value = event.playing;
      if (!event.playing &&
          indexLogic.loopModeList[indexLogic.selectedLoopModeIndex.value] ==
              LoopMode.all) {
        clickedOnNext();
      }
    });
    indexLogic.audioPlayer.loopModeStream.listen((LoopMode event) {});
    indexLogic.audioPlayer.setAudioSource(AudioSource.uri(
      Uri.parse(
          "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.originalSource}"),
      tag: MediaItem(
        id: indexLogic.selectedMusic.value!.id.toString(),
        album: "",
        title: indexLogic.selectedMusic.value!.title.en.toString(),
        artUri: Uri.parse(
            "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.imageUrl}"),
      ),
    ));

    indexLogic.audioPlayer.play();
  }

  void changeLoopMode() {
    if (indexLogic.selectedLoopModeIndex.value == 2) {
      indexLogic.selectedLoopModeIndex.value = 0;
    } else {
      indexLogic.selectedLoopModeIndex.value++;
    }
    indexLogic.audioPlayer.setLoopMode(
        indexLogic.loopModeList[indexLogic.selectedLoopModeIndex.value]);
  }

  void downloadMusic() async {
    EasyLoading.show(status: "Downloading");
    var fileInfo = await DefaultCacheManager().getFileFromCache(
        "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.originalSource}");
    if (fileInfo == null) {
      var file = await DefaultCacheManager().getSingleFile(
          "$imageBaseUrlWithoutSlash${indexLogic.selectedMusic.value!.originalSource}");
      indexLogic.addOfflineMusic(indexLogic.selectedMusic.value);
      EasyLoading.showToast('File Added To Your PlayList');
    } else {
      EasyLoading.showToast('File Already Added To Playlist');
    }
  }
}
