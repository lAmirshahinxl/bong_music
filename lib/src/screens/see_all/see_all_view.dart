import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/see_all/see_all_logic.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../../widgets/bottom_player.dart';

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
                TabBar(
                  controller: logic.tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashBorderRadius: BorderRadius.circular(10),
                  onTap: logic.onTabChanged,
                  unselectedLabelColor:
                      Get.isDarkMode ? Colors.white : Colors.black,
                  indicator: const BubbleTabIndicator(
                    indicatorHeight: 50.0,
                    indicatorColor: Color(0xffFFD700),
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    indicatorRadius: 10,
                  ),
                  tabs: logic.tabList,
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
          horizontalOffset: 500,
          child: GestureDetector(
            onTap: () => logic.goToMusicPage(list[index]),
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        list[index].description.en.toString(),
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
}
