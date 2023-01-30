import 'dart:ui';

import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/see_all/see_all_logic.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../../widgets/bottom_player.dart';
import '../artist_detail/artist_detail_view.dart';

class SeeAllPage extends StatefulWidget {
  const SeeAllPage({super.key});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  final logic = Get.put(SeeAllLogic());

  @override
  void dispose() {
    Get.delete<SeeAllLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 90,
            width: Get.width,
            child: Card(
              color:
                  Get.isDarkMode ? ColorConstants.cardbackground : Colors.white,
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
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Hero(
                        tag: logic.title,
                        child: Text(
                          logic.title,
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
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 35,
                  child: TabBar(
                    controller: logic.tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.zero,
                    splashBorderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    onTap: logic.onTabChanged,
                    unselectedLabelColor:
                        Get.isDarkMode ? Colors.white : Colors.black,
                    labelColor: ColorConstants.gold,
                    indicatorColor: ColorConstants.gold,
                    // indicator: const BubbleTabIndicator(
                    //   indicatorHeight: 50.0,
                    //   indicatorColor: Color(0xffFFD700),
                    //   tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    //   indicatorRadius: 10,
                    // ),
                    tabs: logic.tabList,
                  ),
                ),
                Expanded(
                    child: Obx(
                  () => PageView(
                    controller: logic.pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: logic.onPageViewChanged,
                    children: [
                      ListView.builder(
                        itemCount: logic.latestList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return itemChildPlayList(index, logic.latestList);
                        },
                      ),
                      ListView.builder(
                        itemCount: logic.popularList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return itemChildPlayList(index, logic.latestList);
                        },
                      ),
                      ListView.builder(
                        itemCount: logic.mustWatchList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return itemChildPlayList(index, logic.latestList);
                        },
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          const BottomPlayerWidget()
        ],
      ),
    );
  }

  Widget itemChildPlayList(int index, RxList<MediaChild> list) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 700),
      child: FadeInAnimation(
        child: SlideAnimation(
          duration: const Duration(milliseconds: 700),
          verticalOffset: 100,
          child: GestureDetector(
            onTap: () => logic.goToMusicPage(list[index]),
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${index + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
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
                      Container(
                        width: Get.width * 0.15,
                        height: Get.width * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '$imageBaseUrl/${list[index].imageUrl}'),
                                fit: BoxFit.fill)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[index].title.en.toString(),
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
                          artistListUi(list[index])
                        ],
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Get.bottomSheet(menuBottomSheet(list[index]));
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

  Widget artistListUi(MediaChild mediaChild) {
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

  Widget menuBottomSheet(MediaChild item) {
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
                        imageUrl: '$imageBaseUrl/${item.imageUrl}',
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
                          item.title.en.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        artistListUi(item)
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
                  Get.bottomSheet(selectArtistBottomSheet(item),
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
                onTap: () => logic.goToViewInfo(item),
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
  }

  Widget selectArtistBottomSheet(MediaChild item) {
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
              itemCount: item.artists.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      Get.to(() => ArtistDetailPage(item.artists[index]));
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
                              item.artists[index].name,
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
}
