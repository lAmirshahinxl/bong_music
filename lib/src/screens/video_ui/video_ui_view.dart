import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:animations/animations.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/video_ui/video_ui_logic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../../widgets/bottom_player.dart';
import '../artist_detail/artist_detail_view.dart';
import '../video/video_view.dart';

class VideoUiPage extends StatefulWidget {
  late MediaChild currenMedia;
  File? offlineFile;

  VideoUiPage(this.currenMedia, {this.offlineFile, super.key});

  @override
  State<VideoUiPage> createState() => _VideoUiPageState();
}

class _VideoUiPageState extends State<VideoUiPage> {
  final logic = Get.put(VideoUiLogic());

  @override
  void initState() {
    logic.currenMedia = widget.currenMedia;
    logic.offlineFile = widget.offlineFile;
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<VideoUiLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Get.isDarkMode ? ColorConstants.backgroundColor : Colors.white,
      child: Column(children: [
        SizedBox(
          height: 90,
          width: Get.width,
          child: Card(
            color: ColorConstants.cardbackground,
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
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        if (logic.detailMediaModel.value == null) {}
                        return Text(
                          logic.currenMedia.title.en.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20),
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.transparent),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Obx(() {
                  if (logic.detailMediaModel.value == null) {}
                  return SizedBox(
                    width: Get.width,
                    height: Get.height * 0.25,
                    child: const VideoPage(),
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            logic.currenMedia.description.en,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(logic.currenMedia.shortDescription.en.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                logic.addToFavorite();
                              },
                              icon: Obx(
                                () => Icon(
                                  logic.isFavorite.value
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  size: 30,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              )),
                          IconButton(
                              onPressed: () {
                                logic.downloadVideo();
                              },
                              icon: Icon(
                                Icons.download_rounded,
                                size: 30,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              )),
                          IconButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  menuBottomSheet(),
                                  isScrollControlled: true,
                                );
                              },
                              icon: Icon(
                                Icons.menu_rounded,
                                size: 30,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Obx(
                  () => storiesContainer(),
                ),
                Obx(
                  () => upNextContainer(),
                ),
              ],
            ),
          ),
        ),
        const BottomPlayerWidget()
      ]),
    );
  }

  Widget storiesContainer() {
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

  Widget upNextContainer() {
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
      child: SingleChildScrollView(
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
          InkWell(
            onTap: () {
              Get.back();
              logic.addToFavorite();
            },
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.star_border_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Obx(
                  () => Text(
                    logic.splashLogic.currentLanguage['addToFavorite'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.2),
          ),
          InkWell(
            onTap: () {
              Get.back();
              Get.bottomSheet(selectArtistBottomSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent);
            },
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.upgrade_sharp,
                      color: Colors.white,
                      size: 20,
                    )),
                Obx(
                  () => Text(
                    logic.splashLogic.currentLanguage['goToArtist'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.2),
          ),
          InkWell(
            onTap: logic.goToViewInfo,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                      size: 20,
                    )),
                Obx(
                  () => Text(
                    logic.splashLogic.currentLanguage['viewInfo'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ]),
      ),
    );
  }

  Widget selectArtistBottomSheet() {
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 200,
        ),
        decoration: BoxDecoration(
            color: ColorConstants.backgroundColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
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
            ListView.builder(
              itemCount: logic.detailMediaModel.value!.data.artists.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      Get.to(() => ArtistDetailPage(
                          logic.detailMediaModel.value!.data.artists[index]));
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                logic.detailMediaModel.value!.data
                                    .artists[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.2),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
