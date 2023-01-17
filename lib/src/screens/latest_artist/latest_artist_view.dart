import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:animations/animations.dart';
import 'package:bong/src/screens/latest_artist/latest_artist_logic.dart';
import 'package:bong/src/widgets/network_aware_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/string_constants.dart';
import '../../widgets/bottom_player.dart';
import '../artist_detail/artist_detail_view.dart';

class LatestArtistPage extends StatefulWidget {
  const LatestArtistPage({super.key});

  @override
  State<LatestArtistPage> createState() => _LatestArtistPageState();
}

class _LatestArtistPageState extends State<LatestArtistPage> {
  final logic = Get.put(LatestArtistLogic());

  @override
  void dispose() {
    Get.delete<LatestArtistLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAwareWidget(
          onlineWidget: Column(
        children: [
          Hero(
            tag: 'setting3',
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                height: 90,
                width: Get.width,
                child: Card(
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
                              onPressed: Get.back,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              logic.splashLogic.currentLanguage['artists'],
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
            ),
          ),
          Obx(
            () {
              return Expanded(
                child: AnimatedSwitcherFlip.flipY(
                  duration: const Duration(milliseconds: 500),
                  child: logic.getLatestArtistModel.value == null
                      ? Center(
                          child: LoadingAnimationWidget.inkDrop(
                            color: const Color(0xffFFD700),
                            size: 25,
                          ),
                        )
                      : logic.artistList.isEmpty
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
                          : GridView.builder(
                              itemCount: logic.artistList.length,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 9 / 11,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return itemArtist(index);
                              },
                            ),
                ),
              );
            },
          ),
          const BottomPlayerWidget()
        ],
      )),
    );
  }

  Widget itemArtist(int index) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: 2,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 500,
        child: OpenContainer(
          tappable: false,
          closedColor: Colors.transparent,
          middleColor: Colors.transparent,
          openColor: Colors.transparent,
          closedElevation: 0,
          openElevation: 0,
          transitionDuration: const Duration(milliseconds: 600),
          closedBuilder: (context, action) {
            return Material(
              child: InkWell(
                onTap: () => action.call(),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: CachedNetworkImage(
                        imageUrl:
                            '$imageBaseUrl/${logic.artistList[index].imageUrl}',
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
                      logic.artistList[index].name.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    Text(
                      "${logic.artistList[index].viewsCount} View",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontFamily: '',
                          color: Get.isDarkMode ? Colors.grey : Colors.black),
                    ),
                  ],
                ),
              ),
            );
          },
          openBuilder: (BuildContext context,
              void Function({Object? returnValue}) action) {
            return ArtistDetailPage(logic.artistList[index]);
          },
        ),
      ),
    );
  }
}
