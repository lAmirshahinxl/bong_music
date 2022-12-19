import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:animations/animations.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/artist_detail/artist_detail_logic.dart';
import 'package:bong/src/screens/story/story_view.dart';
import 'package:bong/src/widgets/network_aware_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stretchy_header/stretchy_header.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../../widgets/bottom_player.dart';

class ArtistDetailPage extends StatefulWidget {
  late void Function({Object? returnValue}) action;
  late Artist currentArtist;

  ArtistDetailPage(this.action, this.currentArtist, {super.key});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  final logic = Get.put(ArtistDetailLogic());

  @override
  void initState() {
    logic.currentArtist = widget.currentArtist;
    logic.action = widget.action;

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
                        onPressed: () => logic.action.call(),
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
                    Text(
                      logic.splashLogic.currentLanguage['musics'],
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
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
                          return ListView.builder(
                            itemCount: logic
                                .artistDetailModel.value!.data.media.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, idx) {
                              return itemMusic(idx);
                            },
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

  Widget itemMusic(int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(seconds: 1),
      child: FadeInAnimation(
        duration: const Duration(seconds: 1),
        child: GestureDetector(
          onTap: () => logic.goToMusicPage(MediaChild.fromJson(
              logic.artistDetailModel.value!.data.media[index].toJson())),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Container(
                  width: Get.width * 0.15,
                  height: Get.width * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              '$imageBaseUrl/${logic.artistDetailModel.value!.data.imageUrl}'),
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
                      logic.artistDetailModel.value!.data.media[index].title.en
                          .toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      logic.artistDetailModel.value!.data.media[index]
                          .description.en
                          .toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    )
                  ],
                )
              ],
            ),
          ),
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
}
