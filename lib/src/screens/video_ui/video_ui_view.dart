import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/video_ui/video_ui_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../config/color_constants.dart';
import '../../widgets/bottom_player.dart';
import '../video/video_view.dart';

class VideoUiPage extends StatefulWidget {
  late void Function() action;
  late MediaChild currenMedia;

  VideoUiPage(this.action, this.currenMedia, {super.key});

  @override
  State<VideoUiPage> createState() => _VideoUiPageState();
}

class _VideoUiPageState extends State<VideoUiPage> {
  final logic = Get.put(VideoUiLogic());

  @override
  void initState() {
    logic.currenMedia = widget.currenMedia;
    logic.action = widget.action;
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<VideoUiLogic>();
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
            color: ColorConstants.cardbackground,
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
                        onPressed: () {
                          logic.action.call();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      logic.currenMedia.title.en.toString(),
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  width: Get.width,
                  height: Get.height * 0.25,
                  child: const VideoPage(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            logic.currenMedia.description.en,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(logic.currenMedia.shortDescription.en.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.heart_broken_outlined,
                                size: 30,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.download_rounded,
                                size: 30,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.dialpad_outlined,
                                size: 30,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: 15,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const SizedBox();
                    // return itemChildVideoPlay(context, index, logic);
                  },
                )
              ],
            ),
          ),
        ),
        const BottomPlayerWidget()
      ]),
    );
  }

  // Widget itemChildVideoPlay(
  //     BuildContext context, int index, ExploreLogic logic) {
  //   return AnimationConfiguration.staggeredList(
  //     position: index,
  //     child: SlideAnimation(
  //       verticalOffset: 500,
  //       horizontalOffset: 0,
  //       duration: const Duration(seconds: 1),
  //       child: GestureDetector(
  //         onTap: () async {
  //           try {
  //             final videoLogic = Get.find<VideoLogic>();
  //             await videoLogic.reBuild();
  //           } catch (e) {
  //             EasyLoading.showToast("Error");
  //           }
  //         },
  //         child: Container(
  //           width: Get.width,
  //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //           child: Row(
  //             children: [
  //               SizedBox(
  //                 width: 20,
  //                 child: FittedBox(
  //                   fit: BoxFit.scaleDown,
  //                   child: Text(
  //                     '${index + 1}',
  //                     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
  //                         color: Get.isDarkMode ? Colors.white : Colors.black),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 width: 10,
  //               ),
  //               Container(
  //                 width: Get.width * 0.15,
  //                 height: Get.width * 0.15,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     image: const DecorationImage(
  //                         image: AssetImage('assets/images/avatar.jpg'),
  //                         fit: BoxFit.fill)),
  //               ),
  //               const SizedBox(
  //                 width: 10,
  //               ),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "Ye Roozi",
  //                     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
  //                         color: Get.isDarkMode ? Colors.white : Colors.black),
  //                   ),
  //                   const SizedBox(
  //                     height: 6,
  //                   ),
  //                   Text(
  //                     "Korosh , Sami Low & Raha",
  //                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
  //                         color: Get.isDarkMode ? Colors.white : Colors.black),
  //                   )
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
