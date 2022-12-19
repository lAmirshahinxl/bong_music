import 'dart:ui';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:animations/animations.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bong/src/config/color_constants.dart';
import 'package:bong/src/config/string_constants.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/music/music_logic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final logic = Get.put(MusicLogic());

  @override
  void dispose() {
    Get.delete<MusicLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "$imageBaseUrlWithoutSlash${logic.indexLogic.selectedMusic.value!.imageUrl}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      size: 30,
                    ),
                    onPressed: logic.back,
                  ),
                ),
                Positioned(
                    top: Get.width * 0.2,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.2),
                              child: AnimatedSizeAndFade.showHide(
                                  show: logic.showAnimation.value,
                                  fadeDuration: const Duration(seconds: 1),
                                  sizeDuration: const Duration(seconds: 1),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "$imageBaseUrlWithoutSlash${logic.indexLogic.selectedMusic.value!.imageUrl}",
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => AnimatedSwitcherFlip.flipY(
                                duration: const Duration(seconds: 2),
                                child: logic.showAnimation.value
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      logic
                                                          .indexLogic
                                                          .selectedMusic
                                                          .value!
                                                          .title
                                                          .en
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .copyWith(
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      logic
                                                          .indexLogic
                                                          .selectedMusic
                                                          .value!
                                                          .shortDescription
                                                          .en
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                    )
                                                  ],
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.heart_broken,
                                                        size: 25,
                                                        color: Colors.white))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Obx(() {
                                              return ProgressBar(
                                                progress: logic.indexLogic
                                                    .currentDuration.value,
                                                buffered: logic.indexLogic
                                                    .buffredDuration.value,
                                                total: logic.indexLogic
                                                    .totalDuration.value,
                                                progressBarColor: Colors.white,
                                                baseBarColor: Colors.black
                                                    .withOpacity(0.2),
                                                thumbColor: Colors.white,
                                                thumbGlowColor: Colors.white,
                                                bufferedBarColor: Colors.black
                                                    .withOpacity(0.2),
                                                onSeek: (duration) {
                                                  logic.seekTo(duration);
                                                },
                                                timeLabelTextStyle:
                                                    Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                              );
                                            }),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                    onPressed:
                                                        logic.changeLoopMode,
                                                    icon: Obx(
                                                      () => Icon(
                                                        Icons.repeat_rounded,
                                                        size: 25,
                                                        color: logic.indexLogic
                                                                .loopMode.value
                                                            ? ColorConstants
                                                                .gold
                                                            : Colors.white,
                                                      ),
                                                    )),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const RotatedBox(
                                                      quarterTurns: 270,
                                                      child: Icon(
                                                        Icons
                                                            .fast_forward_rounded,
                                                        size: 25,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                                Obx(
                                                  () => AnimatedSizeAndFade(
                                                    child: logic.indexLogic
                                                            .isPlaying.value
                                                        ? IconButton(
                                                            key: const ValueKey(
                                                                0),
                                                            onPressed: logic
                                                                .indexLogic
                                                                .playOrPause,
                                                            icon: const Icon(
                                                              Icons
                                                                  .pause_outlined,
                                                              size: 35,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : IconButton(
                                                            key: const ValueKey(
                                                                1),
                                                            onPressed: logic
                                                                .indexLogic
                                                                .playOrPause,
                                                            icon: const Icon(
                                                              Icons
                                                                  .play_arrow_rounded,
                                                              size: 35,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons
                                                          .fast_forward_rounded,
                                                      size: 25,
                                                      color: Colors.white,
                                                    )),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.download_rounded,
                                                      size: 25,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    : const SizedBox(
                                        width: 1,
                                      )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                      menuBottomSheet(),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                    size: 35,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Obx(
                            () => storiesContainer(context, logic),
                          ),
                          Obx(
                            () => upNextContainer(context, logic),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget storiesContainer(context, MusicLogic logic) {
    return AnimatedSwitcherFlip.flipX(
        duration: const Duration(milliseconds: 500),
        child: logic.storiesList.isEmpty
            ? const SizedBox(
                width: 1,
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Text(
                              logic.splashLogic.currentLanguage['stories'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: logic.storiesList.length,
                      itemBuilder: (context, index) {
                        return itemStories(context, index);
                      },
                    ),
                  )
                ],
              ));
  }

  Widget itemStories(context, int index) {
    return OpenContainer(
      tappable: false,
      closedColor: Colors.transparent,
      middleColor: Colors.transparent,
      openColor: Colors.transparent,
      closedElevation: 0,
      openElevation: 0,
      transitionDuration: const Duration(milliseconds: 600),
      closedBuilder: (context, action) {
        return GestureDetector(
          onTap: () => action.call(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                horizontalOffset: 500,
                verticalOffset: 0,
                delay: const Duration(milliseconds: 100),
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: CachedNetworkImage(
                        imageUrl: "$imageBaseUrl/${logic.storiesList[index]}",
                        width: 70,
                        height: 70,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 60, 60, 60),
                            highlightColor: Colors.white.withOpacity(0.02),
                            child: Container(
                              width: Get.width * 0.35,
                              height: Get.width * 0.35,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      logic.storiesList[index].id.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      openBuilder: (context, void Function({Object? returnValue}) action) {
        return const SizedBox();
      },
    );
  }

  Widget upNextContainer(context, MusicLogic logic) {
    return AnimatedSwitcherFlip.flipX(
        duration: const Duration(milliseconds: 500),
        child: logic.upnextList.isEmpty
            ? const SizedBox(
                width: 1,
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Text(
                              logic.splashLogic.currentLanguage['upNext'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: logic.upnextList.length,
                    itemBuilder: (context, index) {
                      return itemChildPlayList(context, index);
                    },
                  )
                ],
              ));
  }

  Widget itemChildPlayList(BuildContext context, int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      child: SlideAnimation(
        verticalOffset: 500,
        horizontalOffset: 0,
        duration: const Duration(seconds: 1),
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: InkWell(
            onTap: () => logic.clickedOnItemUpnext(index),
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          '$imageBaseUrl/${logic.upnextList[index].imageUrl}',
                      width: Get.width * 0.15,
                      height: Get.width * 0.15,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (context, url, progress) {
                        return Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 60, 60, 60),
                          highlightColor: Colors.white.withOpacity(0.02),
                          child: Container(
                            width: Get.width * 0.35,
                            height: Get.width * 0.35,
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        logic.upnextList[index].title.en.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        logic.upnextList[index].description.en.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget menuBottomSheet() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstants.backgroundColor),
      child: Column(children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20,
                )),
            Obx(
              () => Text(
                logic.splashLogic.currentLanguage['share'],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20,
                )),
            Obx(
              () => Text(
                logic.splashLogic.currentLanguage['addToPlayList'],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20,
                )),
            Obx(
              () => Text(
                logic.splashLogic.currentLanguage['addToPlayList'],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20,
                )),
            Obx(
              () => Text(
                logic.splashLogic.currentLanguage['addToPlayList'],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20,
                )),
            Obx(
              () => Text(
                logic.splashLogic.currentLanguage['addToPlayList'],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20,
                )),
            Obx(
              () => Text(
                logic.splashLogic.currentLanguage['addToPlayList'],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
