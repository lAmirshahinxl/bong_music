import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:bong/src/config/color_constants.dart';
import 'package:bong/src/screens/select_artist/select_artist_logic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../config/string_constants.dart';

class SelectArtistPage extends StatefulWidget {
  const SelectArtistPage({super.key});

  @override
  State<SelectArtistPage> createState() => _SelectArtistPageState();
}

class _SelectArtistPageState extends State<SelectArtistPage> {
  final logic = Get.put(SelectArtistLogic());

  @override
  void dispose() {
    Get.delete<SelectArtistLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                            onPressed: logic.onBackPressed,
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            logic.currentState.value == CurrentState.artist
                                ? logic
                                    .splashLogic.currentLanguage['selectArtist']
                                : logic.splashLogic
                                    .currentLanguage['selectCategory'],
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
                            onPressed: logic.clickedOnNext,
                            icon: Obx(
                              () => FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  logic.currentState.value ==
                                          CurrentState.artist
                                      ? "Next"
                                      : "Done",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: PageView(
            controller: logic.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) => logic.onPageviewChanged(value),
            scrollDirection: Axis.horizontal,
            children: [artistListView(), categoryListView()],
          ))
        ],
      ),
    );
  }

  Widget artistListView() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: logic.artistList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Obx(
                () {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        verticalOffset: 500.0,
                        duration: const Duration(milliseconds: 700),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  logic.selectedArtistListIndex.contains(index)
                                      ? ColorConstants.gold.withOpacity(0.2)
                                      : ColorConstants.cardbackground,
                              elevation: 0,
                              child: InkWell(
                                onTap: () {
                                  if (logic.selectedArtistListIndex
                                      .contains(index)) {
                                    logic.removeSelectedArtist(index);
                                  } else {
                                    logic.addSelectedArtist(index);
                                  }
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "$imageBaseUrl/${logic.artistList[index].imageUrl}",
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          logic.artistList[index].name
                                              .toString(),
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
                                    if (logic.selectedArtistListIndex
                                        .contains(index))
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.done_rounded,
                                            size: 30,
                                            color: ColorConstants.gold,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
                },
              );
            },
          ),
        ));
  }

  Widget categoryListView() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            itemCount: logic.categoryList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Obx(
                () {
                  return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 2,
                      child: SlideAnimation(
                        verticalOffset: 500.0,
                        duration: const Duration(milliseconds: 700),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: logic.selectedCategoryListIndex
                                      .contains(index)
                                  ? ColorConstants.gold.withOpacity(0.2)
                                  : ColorConstants.cardbackground,
                              elevation: 0,
                              child: InkWell(
                                onTap: () {
                                  if (logic.selectedCategoryListIndex
                                      .contains(index)) {
                                    logic.removeSelectedCategory(index);
                                  } else {
                                    logic.addSelectedCategory(index);
                                  }
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      logic.categoryList[index].title.en
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black),
                                    ),
                                    if (logic.selectedCategoryListIndex
                                        .contains(index))
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.done_rounded,
                                            size: 30,
                                            color: ColorConstants.gold,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
                },
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 20 / 9,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
          ),
        ));
  }
}
