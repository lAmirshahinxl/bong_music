import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:animations/animations.dart';
import 'package:bong/src/config/color_constants.dart';
import 'package:bong/src/config/string_constants.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/artist_detail/artist_detail_view.dart';
import 'package:bong/src/screens/home/home_logic.dart';
import 'package:bong/src/screens/playlist_detail/playlist_detail_view.dart';
import 'package:bong/src/screens/see_all/see_all_view.dart';
import 'package:bong/src/screens/video_ui/video_ui_view.dart';
import 'package:bong/src/widgets/network_aware_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/bottom_player.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return NetworkAwareWidget(
      offlineWidget: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Lottie.asset('assets/lottie/internet.json',
              width: 200, height: 200),
        ),
      ),
      onlineWidget: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(
              () => storiesContainer(context, logic),
            ),
            Obx(
              () => playListContainer(context, logic),
            ),
            Obx(() => ListView.builder(
                itemCount: logic.mediaCategory.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: mediaListContainer(context, logic, index));
                })),
            Obx(
              () => forYouContainer(context, logic),
            ),
          ],
        ),
      ),
    );
  }

  Widget storiesContainer(context, HomeLogic logic) {
    return AnimatedSwitcherFlip.flipX(
        duration: const Duration(milliseconds: 500),
        child: logic.artistList.isEmpty
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
                      TextButton(
                          onPressed: () {},
                          child: Obx(() => Text(
                              logic.splashLogic.currentLanguage['seeAll']))),
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
                      itemCount: logic.artistList.length,
                      itemBuilder: (context, index) {
                        return itemStories(context, index, logic);
                      },
                    ),
                  )
                ],
              ));
  }

  Widget itemStories(context, int index, HomeLogic logic) {
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
                        imageUrl:
                            "$imageBaseUrl/${logic.artistList[index].imageUrl}",
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
                      logic.artistList[index].name,
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
        return ArtistDetailPage(action, logic.artistList[index]);
      },
    );
  }

  Widget playListContainer(BuildContext context, HomeLogic logic) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: logic.playList.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 800),
            child: SlideAnimation(
              horizontalOffset: 500,
              child: Column(
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
                              logic.playList[index].title.en.toString(),
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
                      TextButton(
                          onPressed: () =>
                              logic.goToSeeAllPlayList(logic.playList[index]),
                          child: Obx(() => Text(
                              logic.splashLogic.currentLanguage['seeAll']))),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: (Get.width * 0.35) + 50,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: logic.playList[index].children.length,
                      itemBuilder: (context, horIndex) {
                        return itemPlayList(
                            context, horIndex, logic, logic.playList[index]);
                      },
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  Widget itemPlayList(BuildContext context, int index, HomeLogic logic,
      Playlist currenPlayList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AnimationConfiguration.staggeredList(
        position: index,
        child: SlideAnimation(
          horizontalOffset: 500,
          verticalOffset: 0,
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 500),
          child: OpenContainer(
            tappable: false,
            closedColor: Colors.transparent,
            middleColor: Colors.transparent,
            openColor: Colors.transparent,
            closedElevation: 0,
            openElevation: 0,
            transitionDuration: const Duration(milliseconds: 600),
            closedBuilder: (BuildContext context, void Function() action) {
              return InkWell(
                onTap: () {
                  logic.setSelectedPlayList(index);
                  action.call();
                },
                borderRadius: BorderRadius.circular(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              '$imageBaseUrl/${currenPlayList.children[index].imageUrl}',
                          width: Get.width * 0.35,
                          height: Get.width * 0.35,
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
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            currenPlayList.children[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            openBuilder: (BuildContext context,
                void Function({Object? returnValue}) action) {
              return PlayListDeatilPage(action, currenPlayList.children[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget mediaListContainer(
      BuildContext context, HomeLogic logic, int indexMedia) {
    return AnimatedSwitcherFlip.flipX(
        duration: const Duration(milliseconds: 1000),
        child: logic.mediaCategory[indexMedia].children.isEmpty
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
                            () => Hero(
                              tag: logic.mediaCategory[indexMedia].title.en
                                  .toString(),
                              child: Text(
                                logic.mediaCategory[indexMedia].title.en
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () => logic
                              .goToSeeAllMedia(logic.mediaCategory[indexMedia]),
                          child: Obx(() => Text(
                              logic.splashLogic.currentLanguage['seeAll']))),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: (Get.width * 0.35) + 50,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          logic.mediaCategory[indexMedia].children.length,
                      itemBuilder: (context, index) {
                        return itemMediaChild(
                            context,
                            logic.mediaCategory[indexMedia].children[index],
                            logic,
                            index);
                      },
                    ),
                  )
                ],
              ));
  }

  Widget itemMediaChild(
      BuildContext context, MediaChild mediaChild, HomeLogic logic, int index) {
    if (mediaChild.originalSource.isEmpty) {
      return const SizedBox();
    }
    if (mediaChild.originalSource.contains('.mp4')) {
      return itemVideoMusic(context, mediaChild, logic, index);
    }
    return GestureDetector(
      onTap: () => logic.playMusic(mediaChild, index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: AnimationConfiguration.staggeredList(
          position: index,
          child: SlideAnimation(
            horizontalOffset: 500,
            verticalOffset: 0,
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 500),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: '$imageBaseUrl/${mediaChild.imageUrl}',
                      width: Get.width * 0.35,
                      height: Get.width * 0.35,
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
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        mediaChild.title.en.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
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

  Widget itemVideoMusic(
    BuildContext context,
    MediaChild mediaChild,
    HomeLogic logic,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AnimationConfiguration.staggeredList(
        position: index,
        child: SlideAnimation(
          horizontalOffset: 500,
          verticalOffset: 0,
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 500),
          child: OpenContainer(
            tappable: true,
            closedColor: Colors.transparent,
            closedElevation: 0,
            openElevation: 0,
            transitionDuration: const Duration(milliseconds: 600),
            closedBuilder: (BuildContext context, void Function() action) =>
                SizedBox(
              width: Get.width * 0.7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: '$imageBaseUrl/${mediaChild.imageUrl}',
                        fit: BoxFit.fill,
                        width: Get.width * 0.7,
                        height: Get.width * 0.35,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 60, 60, 60),
                            highlightColor: Colors.white.withOpacity(0.02),
                            child: Container(
                              width: Get.width * 0.7,
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
                    Row(
                      children: [
                        Text(
                          mediaChild.title.en.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ],
                    ),
                    Text(
                      mediaChild.description.en.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
            openBuilder: (BuildContext context,
                void Function({Object? returnValue}) action) {
              return VideoUiPage(action, mediaChild);
            },
          ),
        ),
      ),
    );
  }

  Widget forYouContainer(BuildContext context, HomeLogic logic) {
    return AnimatedSwitcherFlip.flipX(
        duration: const Duration(milliseconds: 1000),
        child: logic.forYouList.isEmpty
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
                              logic.splashLogic.currentLanguage['forYou'],
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
                      Visibility(
                        visible: false,
                        child: TextButton(
                            onPressed: () {},
                            child: Obx(() => Text(
                                logic.splashLogic.currentLanguage['seeAll']))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: logic.forYouList.length,
                      itemBuilder: (context, index) {
                        return itemForYouGrid(context, logic, index);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11,
                              crossAxisCount: 2),
                    ),
                  )
                ],
              ));
  }

  Widget itemForYouGrid(BuildContext context, HomeLogic logic, int index) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 2,
      position: index,
      child: SlideAnimation(
        horizontalOffset: 0,
        verticalOffset: 500,
        delay: const Duration(milliseconds: 100),
        duration: const Duration(milliseconds: 500),
        child: Material(
          child: InkWell(
            onTap: () => logic.goToMusicPage(logic.forYouList[index]),
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        '$imageBaseUrl/${logic.forYouList[index].imageUrl}',
                    fit: BoxFit.fill,
                    width: Get.width * 0.4,
                    height: Get.width * 0.4,
                    progressIndicatorBuilder: (context, url, progress) {
                      return Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 60, 60, 60),
                        highlightColor: Colors.white.withOpacity(0.02),
                        child: Container(
                          width: Get.width * 0.4,
                          height: Get.width * 0.4,
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
                  logic.forYouList[index].title.en.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                Text(
                  logic.forYouList[index].description.en.toString(),
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Get.isDarkMode ? Colors.grey : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
