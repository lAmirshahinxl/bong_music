import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:bong/src/screens/viewed_music/viewed_music_logic.dart';
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
import '../../widgets/network_aware_widget.dart';

class ViewedMusicPage extends StatefulWidget {
  const ViewedMusicPage({super.key});

  @override
  State<ViewedMusicPage> createState() => _ViewedMusicPageState();
}

class _ViewedMusicPageState extends State<ViewedMusicPage> {
  final logic = Get.put(ViewedMusicLogic());

  @override
  void dispose() {
    Get.delete<ViewedMusicLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAwareWidget(
        onlineWidget: Column(
          children: [
            Hero(
              tag: 'setting2',
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
                                logic.splashLogic.currentLanguage['musics'],
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
                    child: logic.getViewedMusicModel.value == null
                        ? Center(
                            child: LoadingAnimationWidget.inkDrop(
                              color: const Color(0xffFFD700),
                              size: 25,
                            ),
                          )
                        : logic.musicList.isEmpty
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
                                itemCount: logic.musicList.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return itemPlaylist(index);
                                },
                              ),
                  ),
                );
              },
            ),
            const BottomPlayerWidget()
          ],
        ),
      ),
    );
  }

  Widget itemPlaylist(int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(seconds: 1),
      child: SlideAnimation(
          verticalOffset: 500,
          duration: const Duration(seconds: 1),
          child: Material(
            child: InkWell(
              onTap: () => logic.goToMusicPage(logic.musicList[index]),
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
                            '$imageBaseUrl/${logic.musicList[index].imageUrl}',
                        width: Get.width * 0.15,
                        height: Get.width * 0.15,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 60, 60, 60),
                            highlightColor: Colors.white.withOpacity(0.02),
                            child: Container(
                              width: Get.width * 0.15,
                              height: Get.width * 0.15,
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
                          logic.musicList[index].title.en.toString(),
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
                          logic.musicList[index].description.en.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
