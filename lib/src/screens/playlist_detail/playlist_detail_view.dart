import 'dart:ui';

import 'package:bong/src/screens/playlist_detail/playlist_detail_logic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../../core/models/home_requests_model.dart';
import '../../widgets/bottom_player.dart';
import '../artist_detail/artist_detail_view.dart';

class PlayListDeatilPage extends StatefulWidget {
  late PlaylistChild currenPlayList;

  PlayListDeatilPage(this.currenPlayList, {super.key});

  @override
  State<PlayListDeatilPage> createState() => _PlayListDeatilPageState();
}

class _PlayListDeatilPageState extends State<PlayListDeatilPage> {
  final logic = Get.put(PlayListDetailLogic());

  @override
  void initState() {
    logic.currenPlayList = widget.currenPlayList.obs;
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<PlayListDetailLogic>();
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
                    Text(
                      logic.currenPlayList.value.title.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 20),
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                            width: Get.width * 0.25,
                            height: Get.width * 0.25,
                            imageUrl:
                                '$imageBaseUrl/${logic.currenPlayList.value.imageUrl}',
                            fit: BoxFit.fill),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                logic.currenPlayList.value.title.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${logic.currenPlayList.value.followers} Subscription',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: ''),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'By Bong Music',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Material(
                                child: IconButton(
                                    onPressed: () => logic.addToFavorite(),
                                    icon: Obx(
                                      () => Icon(
                                        logic.currenPlayList.value.isLiked
                                            ? Icons.star_rounded
                                            : Icons.star_outline_rounded,
                                        size: 25,
                                        color:
                                            logic.currenPlayList.value.isLiked
                                                ? ColorConstants.gold
                                                : Colors.white,
                                      ),
                                    )),
                              ),
                              Material(
                                child: IconButton(
                                    onPressed: () => logic.downloadPlayList(),
                                    icon: Icon(
                                      Icons.download_rounded,
                                      size: 25,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                              ),
                            ],
                          )
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
                    const SizedBox(
                      width: 10,
                    ),
                    Text("${logic.currenPlayList.value.title} on Bong Music"),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Obx(
                    () {
                      if (logic.detailModel.value == null) {
                        return Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 60, 60, 60),
                          highlightColor: Colors.white.withOpacity(0.02),
                          child: ListView.builder(
                            itemCount: 3,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, idx) {
                              return AnimationConfiguration.staggeredList(
                                position: idx,
                                duration: const Duration(seconds: 1),
                                child: SlideAnimation(
                                  verticalOffset: 500,
                                  child: Container(
                                    height: 100,
                                    width: Get.width,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 60, 60, 60),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: logic.detailModel.value!.data.media.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, idx) {
                            return itemChildPlayList(idx);
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        const BottomPlayerWidget()
      ]),
    );
  }

  Widget itemChildPlayList(int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(seconds: 1),
      child: FadeInAnimation(
        duration: const Duration(seconds: 1),
        child: GestureDetector(
          onTap: () => logic.goToMusicPage(MediaChild.fromJson(
              logic.detailModel.value!.data.media[index].toJson())),
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
                                  '$imageBaseUrl/${logic.detailModel.value!.data.media[index].imageUrl}'),
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
                          logic.detailModel.value!.data.media[index].title.en
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
                          height: 6,
                        ),
                        artistListUi(logic.detailModel.value!.data.media[index])
                      ],
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Get.bottomSheet(
                        menuBottomSheet(
                            logic.detailModel.value!.data.media[index]),
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
    );
  }

  Widget menuBottomSheet(MediaChild media) {
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
                        imageUrl: '$imageBaseUrl/${media.imageUrl}',
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
                          media.title.en.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        artistListUi(media)
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
                  Get.bottomSheet(selectArtistBottomSheet(media.artists),
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
                onTap: () => logic.goToViewInfo(media),
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
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  logic.downloadMusic(MediaChild.fromJson(media.toJson()));
                },
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.download_for_offline_rounded,
                          color: Colors.white,
                          size: 20,
                        )),
                    Obx(
                      () => Text(
                        logic.splashLogic.currentLanguage['download'],
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

  Widget selectArtistBottomSheet(List<Artist> artists) {
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
              itemCount: artists.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      Get.to(() => ArtistDetailPage(artists[index]));
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
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                artists[index].name,
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

  Widget artistListUi(MediaChild mediaChild) {
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
}
