import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:animations/animations.dart';
import 'package:bong/src/screens/events_detail/events_detail_view.dart';
import 'package:bong/src/screens/upcoming_events/upcoming_events_logic.dart';
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

class UpComingEventsPage extends StatefulWidget {
  const UpComingEventsPage({super.key});

  @override
  State<UpComingEventsPage> createState() => _UpComingEventsPageState();
}

class _UpComingEventsPageState extends State<UpComingEventsPage> {
  final logic = Get.put(UpcomingEventsLogic());

  @override
  void dispose() {
    Get.delete<UpcomingEventsLogic>();
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
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              logic.splashLogic
                                  .currentLanguage['upcomingEvents'],
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
                    child: logic.getUpcomingEventModel.value == null
                        ? Center(
                            child: LoadingAnimationWidget.inkDrop(
                              color: const Color(0xffFFD700),
                              size: 25,
                            ),
                          )
                        : logic.eventList.isEmpty
                            ? Center(
                                child: Center(
                                    child: Text(
                                  "Not Found Any Item",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                )),
                              )
                            : ListView.builder(
                                itemCount: logic.eventList.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return itemEvent(index);
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
                logic.selectedEvent.value = logic.eventList[index];
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
                            '$imageBaseUrl/${logic.eventList[index].imageUrl}',
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
                                  logic.eventList[index].title.toString(),
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
                                  logic.eventList[index].description.toString(),
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
                                  "${logic.eventList[index].eventDate.year}-${logic.eventList[index].eventDate.month}-${logic.eventList[index].eventDate.day}",
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
                                  logic.eventList[index].status.toString(),
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
}
