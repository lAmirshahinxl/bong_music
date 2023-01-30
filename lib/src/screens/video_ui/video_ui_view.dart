import 'dart:ui';

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
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../../widgets/bottom_player.dart';
import '../artist_detail/artist_detail_view.dart';
import '../video/video_view.dart';
import 'package:bong/src/core/models/detail_media_model.dart'
    as mediaDetailModel;

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      artistListUi(),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    logic.addToFavorite();
                                  },
                                  icon: Obx(() => SvgPicture.asset(
                                        logic.isFavorite.value
                                            ? 'assets/icons/heart_fill_icon.svg'
                                            : 'assets/icons/heart_icon.svg',
                                        width: 20,
                                        height: 20,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ))),
                            ),
                            Expanded(
                              child: IconButton(
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
                            ),
                            Expanded(
                              child: IconButton(
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
                            ),
                          ],
                        ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          artistListUi()
                        ],
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                          menuBottomSheet(logic.upnextList[index]),
                          isScrollControlled: true,
                        );
                      },
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                        color: Get.isDarkMode ? Colors.grey : Colors.black,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget menuBottomSheet([mediaDetailModel.Data? upnextItem]) {
    if (upnextItem == null) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white.withOpacity(0.3)),
                ),
              ),
              Column(children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              '$imageBaseUrl/${logic.indexLogic.selectedMusic.value!.imageUrl}',
                          fit: BoxFit.fill,
                          width: Get.width * 0.15,
                          height: Get.width * 0.15,
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
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            logic.indexLogic.selectedMusic.value!.title.en
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          artistListUi()
                        ],
                      )
                    ],
                  ),
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
                          icon: SvgPicture.asset(
                            'assets/icons/heart_icon.svg',
                            width: 20,
                            height: 20,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          )),
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
            ],
          ),
        ),
      );
    } else {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: '$imageBaseUrl/${upnextItem.imageUrl}',
                      fit: BoxFit.fill,
                      width: Get.width * 0.15,
                      height: Get.width * 0.15,
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
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        upnextItem.title.en.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      artistListUi(upnextItem)
                    ],
                  )
                ],
              ),
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
                logic.addToFavoriteUpnext(upnextItem);
              },
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/heart_icon.svg',
                        width: 20,
                        height: 20,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      )),
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
                Get.bottomSheet(selectArtistUpnextBottomSheet(upnextItem),
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
              onTap: () => logic.goToViewInfoUpnext(upnextItem),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.data_usage_rounded,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                )),
                            Text(
                              logic.detailMediaModel.value!.data.artists[index]
                                  .name,
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

  Widget selectArtistUpnextBottomSheet(mediaDetailModel.Data upnextItem) {
    print(upnextItem.artists.length);
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
              itemCount: upnextItem.artists.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      Get.to(() => ArtistDetailPage(upnextItem.artists[index]));
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.data_usage_rounded,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                )),
                            Text(
                              upnextItem.artists[index].name,
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

  Widget artistListUi([mediaDetailModel.Data? upnextItem]) {
    if (upnextItem != null) {
      if (upnextItem.artists.isEmpty) {
        return const SizedBox();
      }
      if (upnextItem.artists.length == 1) {
        return InkWell(
          onTap: () {
            Get.bottomSheet(selectArtistBottomSheet());
          },
          child: Text(
            upnextItem.artists[0].name.toString(),
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Get.isDarkMode ? Colors.grey : Colors.black),
          ),
        );
      }
    }
    return Obx(
      () {
        if (logic.detailMediaModel.value == null) {
          return const SizedBox();
        }
        if (logic.detailMediaModel.value!.data.artists.length == 1) {
          return InkWell(
            onTap: () {
              Get.bottomSheet(selectArtistBottomSheet());
            },
            child: Text(
              logic.detailMediaModel.value!.data.artists[0].name.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Get.isDarkMode ? Colors.grey : Colors.black),
            ),
          );
        }
        return InkWell(
          onTap: () {
            Get.bottomSheet(selectArtistBottomSheet());
          },
          child: SizedBox(
            height: 20,
            child: ListView.builder(
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Text(
                  index + 1 == 2
                      ? " ${logic.detailMediaModel.value!.data.artists[index].name}"
                      : "${logic.detailMediaModel.value!.data.artists[index].name} &"
                          .toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Get.isDarkMode ? Colors.grey : Colors.black),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
