import 'package:animations/animations.dart';
import 'package:bong/src/screens/music/music_view.dart';
import 'package:bong/src/screens/profile/profile_logic.dart';
import 'package:bong/src/screens/video_ui/video_ui_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/string_constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProfileLogic());
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        tabListContainer(context, logic),
        recentlyPlayedContainer(context, logic)
      ]),
    );
  }

  Widget tabListContainer(BuildContext context, ProfileLogic logic) {
    return Obx(() => ListView.builder(
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
                  child: Hero(
                    tag: 'setting${index + 1}',
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          if (index == 0) {
                            logic.goToViewedPlaylist();
                          }
                          if (index == 1) {
                            logic.goToViewedMusic();
                          }
                          if (index == 2) {
                            logic.goToLatestArtist();
                          }
                          if (index == 3) {
                            logic.goToPodcast();
                          }
                          if (index == 4) {
                            logic.goToViewedVideo();
                          }
                          if (index == 5) {
                            logic.goToFavoritePage();
                          }
                          if (index == 6) {
                            logic.goToSettingPage();
                          }
                          if (index == 7) {
                            logic.goToOfflineMusic();
                          }
                          if (index == 8) {
                            logic.goToLoginPage();
                          }
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                            width: Get.width,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            logic.tabListStatics[index]['icon'],
                                            size: 25,
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            logic.tabListStatics[index]
                                                    ['name'] ??
                                                '',
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
                                          size: 15,
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
                      ),
                    ),
                  ),
                ));
          },
        ));
  }

  Widget recentlyPlayedContainer(BuildContext context, ProfileLogic logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Obx(
          () {
            if (logic.indexLogic.recentlyPlayed.isEmpty) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Recently Added',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => ListView.builder(
            itemCount: logic.indexLogic.recentlyPlayed.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return itemRecently(context, index, logic);
            },
          ),
        )
      ],
    );
  }

  Widget itemRecently(BuildContext context, int index, ProfileLogic logic) {
    return AnimationConfiguration.staggeredList(
        position: index,
        child: SlideAnimation(
          verticalOffset: 500,
          horizontalOffset: 0,
          duration: const Duration(milliseconds: 500),
          child: OpenContainer(
            tappable: true,
            closedColor: Colors.transparent,
            closedElevation: 0,
            openElevation: 0,
            transitionDuration: const Duration(milliseconds: 600),
            closedBuilder: (context, action) {
              return Material(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '$imageBaseUrl/${logic.indexLogic.recentlyPlayed[index].imageUrl}',
                                width: 60,
                                height: 60,
                                fit: BoxFit.fill,
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return Shimmer.fromColors(
                                    baseColor:
                                        const Color.fromARGB(255, 60, 60, 60),
                                    highlightColor:
                                        Colors.white.withOpacity(0.02),
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
                                  logic
                                      .indexLogic.recentlyPlayed[index].title.en
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  logic.indexLogic.recentlyPlayed[index]
                                      .description.en,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                        Icon(
                          logic.indexLogic.recentlyPlayed[index].originalSource
                                  .contains('.mp4')
                              ? Icons.video_collection_rounded
                              : Icons.music_note_rounded,
                          size: 25,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        )
                      ]),
                ),
              );
            },
            openBuilder: (context, action) {
              if (logic.indexLogic.recentlyPlayed[index].originalSource
                  .contains('.mp4')) {
                return VideoUiPage(logic.indexLogic.recentlyPlayed[index]);
              } else {
                logic.indexLogic.selectedMusic.value =
                    logic.indexLogic.recentlyPlayed[index];
                return MusicPage();
              }
            },
          ),
        ));
  }
}
