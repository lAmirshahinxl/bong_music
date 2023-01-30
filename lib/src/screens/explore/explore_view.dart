import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:animations/animations.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/explore/explore_logic.dart';
import 'package:bong/src/screens/story/story_view.dart';
import 'package:bong/src/screens/video/video_logic.dart';
import 'package:bong/src/screens/video/video_view.dart';
import 'package:bong/src/screens/video_ui/video_ui_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../../widgets/bottom_player.dart';
import '../playlist_detail/playlist_detail_view.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ExploreLogic());
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Obx(
            () => storiesContainer(context, logic),
          ),
          tabListContainer(context, logic),
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
            () => videoListContainer(context, logic),
          ),
          Obx(
            () => trendingMusicListContainer(context, logic),
          ),
          Obx(
            () => trendingMusicListContainer(context, logic),
          )
        ],
      ),
    );
  }

  Widget mediaListContainer(
      BuildContext context, ExploreLogic logic, int indexMedia) {
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
                          onPressed: () => logic.homeLogic
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

  Widget artistListUi(
      ExploreLogic logic, MediaChild mediaChild, BuildContext context) {
    if (mediaChild.artists.isEmpty) {
      return Text(
        "",
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Get.isDarkMode ? Colors.grey : Colors.black),
      );
    }
    if (mediaChild.artists.length == 1) {
      return Text(
        mediaChild.artists[0].name.toString(),
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Get.isDarkMode ? Colors.grey : Colors.black),
      );
    }
    return SizedBox(
      height: 20,
      child: ListView.builder(
        itemCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              index + 1 == 2
                  ? " ${mediaChild.artists[index].name}"
                  : "${mediaChild.artists[index].name} &".toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Get.isDarkMode ? Colors.grey : Colors.black),
            ),
          );
        },
      ),
    );
  }

  Widget itemMediaChild(BuildContext context, MediaChild mediaChild,
      ExploreLogic logic, int index) {
    if (mediaChild.originalSource.isEmpty) {
      return const SizedBox();
    }
    if (mediaChild.originalSource.contains('.mp4')) {
      return itemVideoMusic(context, mediaChild, logic, index);
    }
    return GestureDetector(
      onTap: () => logic.homeLogic.playMusic(mediaChild, index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: AnimationConfiguration.staggeredList(
          position: index,
          child: FadeInAnimation(
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              width: Get.width * 0.35,
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
                        errorWidget: (context, url, error) {
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
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: artistListUi(logic, mediaChild, context)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget playListContainer(BuildContext context, ExploreLogic logic) {
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
                          onPressed: () => logic.homeLogic
                              .goToSeeAllPlayList(logic.playList[index]),
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

  Widget itemPlayList(BuildContext context, int index, ExploreLogic logic,
      Playlist currenPlayList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AnimationConfiguration.staggeredList(
        position: index,
        child: FadeInAnimation(
          duration: const Duration(milliseconds: 300),
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
                  logic.homeLogic.setSelectedPlayList(index);
                  action.call();
                },
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: Get.width * 0.35,
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
                                baseColor:
                                    const Color.fromARGB(255, 60, 60, 60),
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
                ),
              );
            },
            openBuilder: (BuildContext context,
                void Function({Object? returnValue}) action) {
              return PlayListDeatilPage(currenPlayList.children[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget storiesContainer(context, ExploreLogic logic) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: logic.storyList.isEmpty ? 0 : 170,
      child: AnimatedSwitcherFlip.flipY(
        duration: const Duration(milliseconds: 500),
        child: logic.storyList.isEmpty
            ? const SizedBox(
                width: 0,
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
                      itemCount: logic.storyList.length,
                      itemBuilder: (context, index) {
                        return itemStories(context, index, logic);
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget itemStories(context, int index, ExploreLogic logic) {
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
              child: FadeInAnimation(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: CachedNetworkImage(
                        imageUrl: "$imageBaseUrl/${logic.storyList[index].url}",
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
                      logic.storyList[index].url,
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
        return Storypage(action, [logic.storyList[index]]);
      },
    );
  }

  Widget tabListContainer(BuildContext context, ExploreLogic logic) {
    return ListView.builder(
      itemCount: logic.tabListStatics.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              horizontalOffset: -500,
              verticalOffset: 0,
              child: Material(
                child: InkWell(
                  onTap: () =>
                      Get.toNamed(logic.tabListStatics[index]['route']),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  logic.tabListStatics[index]['icon'],
                                  size: 30,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  logic.tabListStatics[index]['name'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                )
                              ],
                            ),
                            RotatedBox(
                              quarterTurns: 270,
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 20,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.3),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget trendingMusicListContainer(BuildContext context, ExploreLogic logic) {
    return AnimatedSwitcherFlip.flipX(
        duration: const Duration(milliseconds: 1000),
        child: logic.storyList.isEmpty
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
                              logic
                                  .splashLogic.currentLanguage['trendingMusic'],
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
                          SvgPicture.asset(
                            'assets/icons/music-tune.svg',
                            width: 25,
                            height: 25,
                          )
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
                    height: (Get.width * 0.35) + 50,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: logic.storyList.length,
                      itemBuilder: (context, index) {
                        return itemTrendingMusic(context, index, logic);
                      },
                    ),
                  )
                ],
              ));
  }

  Widget itemTrendingMusic(
      BuildContext context, int index, ExploreLogic logic) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AnimationConfiguration.staggeredList(
        position: index,
        child: FadeInAnimation(
          duration: const Duration(milliseconds: 300),
          child: GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: Get.width * 0.35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width * 0.35,
                      height: Get.width * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/playlist.jpeg'),
                              fit: BoxFit.fill)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Todays Top Hits",
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
                      "Koroosh, Sami",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget videoListContainer(BuildContext context, ExploreLogic logic) {
    return AnimatedSwitcherFlip.flipX(
        duration: const Duration(milliseconds: 1000),
        child: logic.storyList.isEmpty
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
                              logic.splashLogic.currentLanguage['newVideos'],
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
                  // SizedBox(
                  //   height: (Get.width * 0.35) + 50,
                  //   child: ListView.builder(
                  //     physics: const BouncingScrollPhysics(),
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: logic.storyList.length,
                  //     itemBuilder: (context, index) {
                  //       return itemVideoMusic(context, index, logic);
                  //     },
                  //   ),
                  // )
                ],
              ));
  }

  Widget itemVideoMusic(
    BuildContext context,
    MediaChild mediaChild,
    ExploreLogic logic,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AnimationConfiguration.staggeredList(
        position: index,
        child: FadeInAnimation(
          duration: const Duration(milliseconds: 300),
          child: OpenContainer(
            tappable: true,
            closedColor: Colors.transparent,
            closedElevation: 0,
            openElevation: 0,
            transitionDuration: const Duration(milliseconds: 600),
            closedBuilder: (BuildContext context, void Function() action) =>
                SizedBox(
              width: Get.width * 0.35,
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
                      height: 8,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
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
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        artistListUi(logic, mediaChild, context),
                      ],
                    )
                  ],
                ),
              ),
            ),
            openBuilder: (BuildContext context,
                void Function({Object? returnValue}) action) {
              return VideoUiPage(mediaChild);
            },
          ),
        ),
      ),
    );
  }
}
