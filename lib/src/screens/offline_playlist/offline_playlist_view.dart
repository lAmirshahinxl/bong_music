import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:animations/animations.dart';
import 'package:bong/src/screens/offline_playlist/offline_playlist_logic.dart';
import 'package:bong/src/widgets/bottom_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../music/music_view.dart';
import '../video_ui/video_ui_view.dart';

class OfflinePLaylistPage extends StatefulWidget {
  const OfflinePLaylistPage({super.key});

  @override
  State<OfflinePLaylistPage> createState() => _OfflinePLaylistPageState();
}

class _OfflinePLaylistPageState extends State<OfflinePLaylistPage> {
  final logic = Get.put(OfflinePlaylistLogic());

  @override
  void dispose() {
    Get.delete<OfflinePlaylistLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              height: 90,
              width: Get.width,
              child: Card(
                color: Get.isDarkMode
                    ? ColorConstants.cardbackground
                    : Colors.white,
                elevation: 1,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: true,
                          child: IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'setting8',
                          child: Obx(
                            () => Text(
                              logic.splashLogic.currentLanguage['myPlaylist'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 20),
                            ),
                          ),
                        ),
                        Obx(
                          () => IconButton(
                            onPressed: () {
                              if (logic
                                  .indexLogic.offlineMusicUrlList.isEmpty) {
                                return;
                              }
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "Are You Sure For Delete All Items?",
                                style: AlertStyle(
                                    backgroundColor:
                                        ColorConstants.backgroundColor,
                                    titleStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.white)),
                                buttons: [
                                  DialogButton(
                                    onPressed: () {
                                      logic.removeAllCaches();
                                    },
                                    color: ColorConstants.gold,
                                    child: const Text(
                                      "Confirm",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                  DialogButton(
                                    onPressed: () => Navigator.pop(context),
                                    color: Colors.grey,
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  )
                                ],
                              ).show();
                            },
                            icon: Icon(
                              Icons.delete,
                              color:
                                  logic.indexLogic.offlineMusicUrlList.isEmpty
                                      ? Colors.transparent
                                      : Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                              size: 25,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Expanded(
              child: AnimatedSwitcherFlip.flipX(
                duration: const Duration(seconds: 1),
                child: logic.indexLogic.offlineMusicUrlList.isEmpty
                    ? Center(
                        child: Text(
                          "Not Found Any Item",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      )
                    : ListView.builder(
                        itemCount: logic.indexLogic.offlineMusicUrlList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return itemRecently(index);
                        },
                      ),
              ),
            ),
          ),
          const BottomPlayerWidget()
        ],
      ),
    );
  }

  Widget itemRecently(int index) {
    return AnimationConfiguration.staggeredList(
        position: index,
        child: SlideAnimation(
            verticalOffset: 500,
            horizontalOffset: 0,
            duration: const Duration(milliseconds: 500),
            child: Material(
              child: InkWell(
                onTap: () => logic.clickedOnItem(index),
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
                                    '$imageBaseUrl/${logic.indexLogic.offlineMusicUrlList[index].imageUrl}',
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
                                  logic.indexLogic.offlineMusicUrlList[index]
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
                          logic.indexLogic.offlineMusicUrlList[index]
                                  .originalSource
                                  .contains('.mp4')
                              ? Icons.video_collection_rounded
                              : Icons.music_note_rounded,
                          size: 25,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        )
                      ]),
                ),
              ),
            )));
  }
}
