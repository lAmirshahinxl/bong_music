import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:bong/src/screens/explore/explore_view.dart';
import 'package:bong/src/screens/home/home_view.dart';
import 'package:bong/src/screens/index/index_logic.dart';
import 'package:bong/src/screens/profile/profile_view.dart';
import 'package:bong/src/screens/search/search_view.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../config/color_constants.dart';
import '../../widgets/bottom_player.dart';

class IndexPage extends StatelessWidget {
  IndexPage({super.key});
  final logic = Get.put(IndexLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Center(
            child: Obx(
          () => AnimatedSwitcherFlip.flipY(
              duration: const Duration(milliseconds: 500),
              child: Text(
                logic.headerText.value,
                key: ValueKey(logic.selectedIndex.value),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Get.isDarkMode ? ColorConstants.gold : Colors.black,
                    fontSize: 20),
              )),
        )),
        toolbarHeight: 50,
      ),
      body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: PageView(
                  controller: logic.pageController,
                  onPageChanged: logic.onPageChanged,
                  children: const [
                    HomePage(),
                    ExplorePage(),
                    Searchpage(),
                    ProfilePage()
                  ],
                ),
              ),
              const BottomPlayerWidget()
            ],
          )),
      bottomNavigationBar: Obx(
        () => FlashyTabBar(
          selectedIndex: logic.selectedIndex.value,
          shadows: [
            BoxShadow(
                color: Get.isDarkMode
                    ? ColorConstants.backgroundColor
                    : Colors.white,
                blurRadius: 20,
                spreadRadius: 10,
                offset: Offset(0, -1))
          ],
          backgroundColor: Get.isDarkMode
              ? const Color.fromARGB(174, 44, 44, 44)
              : Colors.white,
          showElevation: true,
          animationDuration: const Duration(milliseconds: 250),
          onItemSelected: (index) => logic.selectedIndex.value = index,
          items: [
            FlashyTabBarItem(
                icon: Icon(
                  Icons.home_filled,
                  color: Get.isDarkMode
                      ? logic.selectedIndex.value == 0
                          ? Colors.transparent
                          : Colors.grey
                      : logic.selectedIndex.value == 0
                          ? Colors.transparent
                          : Colors.grey,
                  size: 23,
                ),
                title: Text(
                  logic.splashLogic.currentLanguage['home'],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color:
                          Get.isDarkMode ? ColorConstants.gold : Colors.black),
                ),
                activeColor:
                    Get.isDarkMode ? ColorConstants.gold : Colors.black),
            FlashyTabBarItem(
              icon: Icon(
                Icons.travel_explore_rounded,
                color: Get.isDarkMode
                    ? logic.selectedIndex.value == 1
                        ? Colors.transparent
                        : Colors.grey
                    : logic.selectedIndex.value == 1
                        ? Colors.transparent
                        : Colors.grey,
                size: 23,
              ),
              title: Text(
                logic.splashLogic.currentLanguage['explore'],
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Get.isDarkMode ? ColorConstants.gold : Colors.black),
              ),
              activeColor: Get.isDarkMode ? ColorConstants.gold : Colors.black,
            ),
            FlashyTabBarItem(
                icon: Icon(
                  Icons.manage_search_rounded,
                  color: Get.isDarkMode
                      ? logic.selectedIndex.value == 2
                          ? Colors.transparent
                          : Colors.grey
                      : logic.selectedIndex.value == 2
                          ? Colors.transparent
                          : Colors.grey,
                  size: 23,
                ),
                title: Text(
                  logic.splashLogic.currentLanguage['search'],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color:
                          Get.isDarkMode ? ColorConstants.gold : Colors.black),
                ),
                activeColor:
                    Get.isDarkMode ? ColorConstants.gold : Colors.black),
            FlashyTabBarItem(
                icon: Icon(
                  Icons.format_align_right_rounded,
                  color: Get.isDarkMode
                      ? logic.selectedIndex.value == 3
                          ? Colors.transparent
                          : Colors.grey
                      : logic.selectedIndex.value == 3
                          ? Colors.transparent
                          : Colors.grey,
                  size: 23,
                ),
                title: Text(
                  logic.splashLogic.currentLanguage['profile'],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color:
                          Get.isDarkMode ? ColorConstants.gold : Colors.black),
                ),
                activeColor:
                    Get.isDarkMode ? ColorConstants.gold : Colors.black),
          ],
        ),
      ),
    );
  }
}
