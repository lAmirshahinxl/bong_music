import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:bong/src/screens/music_videos/music_videos_logic.dart';
import 'package:bong/src/widgets/network_aware_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../../core/models/home_requests_model.dart';
import '../../widgets/bottom_player.dart';
import '../artist_detail/artist_detail_view.dart';

class MusicVideosPage extends StatefulWidget {
  const MusicVideosPage({super.key});

  @override
  State<MusicVideosPage> createState() => _MusicVideosPageState();
}

class _MusicVideosPageState extends State<MusicVideosPage> {
  final logic = Get.put(MusicVideosLogic());

  @override
  void dispose() {
    Get.delete<MusicVideosLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAwareWidget(
          onlineWidget: Column(
        children: [
          FittedBox(
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
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            logic.splashLogic.currentLanguage['newMusic'],
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
          Obx(
            () {
              return Expanded(
                child: AnimatedSwitcherFlip.flipY(
                  duration: const Duration(milliseconds: 500),
                  child: logic.getnewMusicModel.value == null
                      ? Center(
                          child: LoadingAnimationWidget.inkDrop(
                            color: const Color(0xffFFD700),
                            size: 25,
                          ),
                        )
                      : logic.mediaList.isEmpty
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
                            ))
                          : GridView.builder(
                              itemCount: logic.mediaList.length,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 9 / 11,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return itemVideo(index);
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

  Widget itemVideo(int index) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: 2,
      child: Material(
        child: InkWell(
          onTap: () => logic.clickedOnItemUpnext(logic.mediaList[index]),
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: '$imageBaseUrl/${logic.mediaList[index].imageUrl}',
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
                logic.mediaList[index].title.en.toString(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              artistListUi(logic.mediaList[index])
            ],
          ),
        ),
      ),
    );
  }

  Widget artistListUi(MediaChild item) {
    if (item.artists.isEmpty) {
      return Text(
        "",
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Get.isDarkMode ? Colors.grey : Colors.black),
      );
    }
    if (item.artists.length == 1) {
      return InkWell(
        onTap: () {
          Get.bottomSheet(selectArtistBottomSheet(item));
        },
        child: Text(
          item.artists[0].name.toString(),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Get.isDarkMode ? Colors.grey : Colors.black),
        ),
      );
    }
    return InkWell(
      onTap: () {
        Get.bottomSheet(selectArtistBottomSheet(item));
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
                  ? " ${item.artists[index].name}"
                  : "${item.artists[index].name} &".toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Get.isDarkMode ? Colors.grey : Colors.black),
            );
          },
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
