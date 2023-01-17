import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:bong/src/config/color_constants.dart';
import 'package:bong/src/core/models/get_upcoming_events_model.dart';
import 'package:bong/src/screens/events_detail/events_detail_logic.dart';
import 'package:bong/src/widgets/dash_line.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:url_launcher/url_launcher_string.dart';

import '../../config/string_constants.dart';
import '../../widgets/bottom_player.dart';
import '../../widgets/network_aware_widget.dart';

class EventsDetailPage extends StatefulWidget {
  EventModel eventModel;

  EventsDetailPage(this.eventModel, {super.key});

  @override
  State<EventsDetailPage> createState() => _EventsDetailPageState();
}

class _EventsDetailPageState extends State<EventsDetailPage> {
  final logic = Get.put(EventsDetailLogic());

  @override
  void initState() {
    logic.model = widget.eventModel;
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<EventsDetailLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAwareWidget(
        onlineWidget: Stack(
          children: [
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              child: Column(
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
                                Text(
                                  logic.model.title.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
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
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '$imageBaseUrl/${logic.model.imageUrl}',
                                width: Get.width * 0.6,
                                height: Get.width * 0.6,
                                fit: BoxFit.fill,
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return Shimmer.fromColors(
                                    baseColor:
                                        const Color.fromARGB(255, 60, 60, 60),
                                    highlightColor:
                                        Colors.white.withOpacity(0.02),
                                    child: Container(
                                      width: Get.width * 0.35,
                                      height: Get.width * 0.35,
                                      color: Colors.black,
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Shimmer.fromColors(
                                    baseColor:
                                        const Color.fromARGB(255, 60, 60, 60),
                                    highlightColor:
                                        Colors.white.withOpacity(0.02),
                                    child: Container(
                                      width: Get.width * 0.35,
                                      height: Get.width * 0.35,
                                      color: Colors.black,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                logic.model.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                logic.model.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          const DashLineView(
                            dashColor: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Location : ${logic.model.location}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Status : ${logic.model.status}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Date : ${logic.model.eventDate.year}-${logic.model.eventDate.month}-${logic.model.eventDate.day}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontFamily: '',
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Call : ${logic.model.callNumber}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontFamily: '',
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Column(
                children: [
                  Material(
                    color: ColorConstants.gold,
                    child: InkWell(
                      onTap: logic.clickedOnPuchase,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Purchase",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const BottomPlayerWidget()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
