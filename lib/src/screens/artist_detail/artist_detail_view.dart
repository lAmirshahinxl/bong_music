import 'dart:ui';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:animations/animations.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/artist_detail/artist_detail_logic.dart';
import 'package:bong/src/screens/see_all_artistmusic/see_all_artistmusic_view.dart';
import 'package:bong/src/screens/story/story_view.dart';
import 'package:bong/src/screens/video_ui/video_ui_view.dart';
import 'package:bong/src/widgets/network_aware_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stretchy_header/stretchy_header.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../../widgets/bottom_player.dart';
import '../events_detail/events_detail_view.dart';
import '../playlist_detail/playlist_detail_view.dart';
import 'package:bong/src/core/models/artist_detail_model.dart' as artistdetail;

class ArtistDetailPage extends StatefulWidget {
  late Artist currentArtist;

  ArtistDetailPage(this.currentArtist, {super.key});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  final logic = Get.put(ArtistDetailLogic());

  @override
  void initState() {
    logic.currentArtist = widget.currentArtist;

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ArtistDetailLogic>();
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
                      logic.currentArtist.name.toString(),
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
          child: NetworkAwareWidget(
            offlineWidget: Center(
              child: Lottie.asset('assets/lottie/internet.json',
                  width: 200, height: 200),
            ),
            onlineWidget: StretchyHeader.singleChild(
              headerData: HeaderData(
                highlightHeader: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3), blurRadius: 10)
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          logic.currentArtist.name.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.headset_mic_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${logic.currentArtist.likesCount} Likes",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                headerHeight: Get.height * 0.4,
                blurContent: true,
                blurColor: ColorConstants.backgroundColor,
                header: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: "$imageBaseUrl/${logic.currentArtist.imageUrl}",
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) {
                      return Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 60, 60, 60),
                        highlightColor: Colors.white.withOpacity(0.02),
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.4,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => AnimatedSizeAndFade.showHide(
                        show: logic.artistDetailModel.value != null &&
                            logic.artistDetailModel.value!.data.stories
                                .isNotEmpty,
                        child: Column(
                          children: [
                            Text(
                              logic.splashLogic.currentLanguage['stories'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                            ),
                            SizedBox(
                              height: 100,
                              width: Get.width,
                              child: ListView.builder(
                                itemCount: logic.artistDetailModel.value == null
                                    ? 0
                                    : 1,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, idx) {
                                  return itemStories();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () {
                        if (logic.artistDetailModel.value == null) {
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
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 60, 60, 60),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              if (logic.artistDetailModel.value!.data.musics
                                  .isNotEmpty)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      logic.splashLogic
                                          .currentLanguage['musics'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black),
                                    ),
                                    if (logic.artistDetailModel.value!.data
                                            .musics.length >
                                        5)
                                      TextButton(
                                          onPressed: () {
                                            Get.to(
                                                () =>
                                                    const SeeAllArtistMusicPage(),
                                                arguments: {
                                                  "musicList": logic
                                                      .artistDetailModel
                                                      .value!
                                                      .data
                                                      .musics
                                                });
                                          },
                                          child: Obx(() => Text(logic
                                              .splashLogic
                                              .currentLanguage['seeAll']))),
                                  ],
                                ),
                              ListView.builder(
                                itemCount: logic.artistDetailModel.value!.data
                                            .musics.length >
                                        5
                                    ? 5
                                    : logic.artistDetailModel.value!.data.musics
                                        .length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, idx) {
                                  return itemMusic(idx);
                                },
                              ),
                              if (logic.playLists.isNotEmpty)
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          logic.splashLogic
                                              .currentLanguage['playList'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: (Get.width * 0.35) + 50,
                                      child: ListView.builder(
                                        itemCount: logic.playLists.length,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, idx) {
                                          return itemPlayList(
                                              logic.playLists[idx], idx);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              if (logic.albums.isNotEmpty)
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Albums",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: (Get.width * 0.35) + 50,
                                      child: ListView.builder(
                                        itemCount: logic.albums.length,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, idx) {
                                          return itemPlayList(
                                              logic.albums[idx], idx);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              if (logic.artistDetailModel.value!.data
                                  .musicVideos.isNotEmpty)
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          logic.splashLogic
                                              .currentLanguage['musicVideos'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: (Get.width * 0.35) + 50,
                                      child: ListView.builder(
                                        itemCount: logic.artistDetailModel
                                            .value!.data.musicVideos.length,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, idx) {
                                          return itemVideoMusic(
                                              logic.artistDetailModel.value!
                                                  .data.musicVideos[idx],
                                              idx);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              if (logic.artistDetailModel.value!.data
                                  .upcomingEvent.isNotEmpty)
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          logic.splashLogic.currentLanguage[
                                              'upcomingEvents'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: (Get.width * 0.35),
                                      child: ListView.builder(
                                        itemCount: logic.artistDetailModel
                                            .value!.data.upcomingEvent.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, idx) {
                                          return itemEvent(idx);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const BottomPlayerWidget()
      ]),
    );
  }

  Widget itemEvent(int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(seconds: 1),
      child: FadeInAnimation(
        duration: const Duration(seconds: 1),
        child: OpenContainer(
          tappable: false,
          closedColor: Colors.transparent,
          middleColor: Colors.transparent,
          openColor: Colors.transparent,
          closedElevation: 0,
          openElevation: 0,
          transitionDuration: const Duration(milliseconds: 600),
          closedBuilder: (context, action) {
            return GestureDetector(
              onTap: () {
                logic.selectedEvent.value =
                    logic.artistDetailModel.value!.data.upcomingEvent[index];
                action.call();
              },
              child: Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            '$imageBaseUrl/${logic.artistDetailModel.value!.data.upcomingEvent[index].imageUrl}',
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
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  logic.artistDetailModel.value!.data
                                      .upcomingEvent[index].title
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
                                Text(
                                  logic.artistDetailModel.value!.data
                                      .upcomingEvent[index].description
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${logic.artistDetailModel.value!.data.upcomingEvent[index].eventDate.year}-${logic.artistDetailModel.value!.data.upcomingEvent[index].eventDate.month}-${logic.artistDetailModel.value!.data.upcomingEvent[index].eventDate.day}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  logic.artistDetailModel.value!.data
                                      .upcomingEvent[index].status
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          openBuilder: (context, action) {
            return EventsDetailPage(logic.selectedEvent.value!);
          },
        ),
      ),
    );
  }

  Widget itemVideoMusic(
    artistdetail.Media mediaChild,
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
                        artistListUi(mediaChild),
                      ],
                    )
                  ],
                ),
              ),
            ),
            openBuilder: (BuildContext context,
                void Function({Object? returnValue}) action) {
              return VideoUiPage(MediaChild.fromJson(mediaChild.toJson()));
            },
          ),
        ),
      ),
    );
  }

  Widget artistListUi(artistdetail.Media mediaChild) {
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

  Widget itemMusic(int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(seconds: 1),
      child: FadeInAnimation(
        duration: const Duration(seconds: 1),
        child: GestureDetector(
          onTap: () => logic.goToMusicPage(MediaChild.fromJson(
              logic.artistDetailModel.value!.data.musics[index].toJson())),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: Get.width * 0.15,
                      height: Get.width * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  '$imageBaseUrl/${logic.artistDetailModel.value!.data.musics[index].imageUrl}'),
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
                          logic.artistDetailModel.value!.data.musics[index]
                              .title.en
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
                        artistListUi(
                            logic.artistDetailModel.value!.data.musics[index])
                      ],
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Get.bottomSheet(menuBottomSheet(
                          logic.artistDetailModel.value!.data.musics[index]
                              .artists,
                          logic.artistDetailModel.value!.data.musics[index]));
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

  Widget menuBottomSheet(List<Artist> artists, artistdetail.Media media) {
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
                  Get.bottomSheet(selectArtistBottomSheet(artists),
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

  Widget itemStories() {
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
              position: 0,
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
                            "$imageBaseUrl/${logic.artistDetailModel.value!.data.imageUrl}",
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
                      logic.artistDetailModel.value!.data.name,
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
        return Storypage(action, logic.artistDetailModel.value!.data.stories);
      },
    );
  }

  Widget itemPlayList(PlaylistChild item, int index) {
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
                  // logic.setSelectedPlayList(index);
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
                          imageUrl: '$imageBaseUrl/${item.imageUrl}',
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
                            item.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontFamily: '',
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
              return PlayListDeatilPage(item);
            },
          ),
        ),
      ),
    );
  }
}
