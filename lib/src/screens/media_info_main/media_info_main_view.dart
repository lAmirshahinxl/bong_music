import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/media_info/media_info_logic.dart';
import 'package:bong/src/widgets/bottom_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

import 'media_info_main_logic.dart';

class MediaInfoMainPage extends StatefulWidget {
  const MediaInfoMainPage({super.key});

  @override
  State<MediaInfoMainPage> createState() => _MediaInfoMainPageState();
}

class _MediaInfoMainPageState extends State<MediaInfoMainPage> {
  final logic = Get.put(MediaInfoMainLogic());

  @override
  void dispose() {
    Get.delete<MediaInfoMainLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                            logic.splashLogic.currentLanguage['viewInfo'],
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
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Song : ${logic.selectedMedia!.title.en.toString()}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => Align(
                alignment: Alignment.center,
                child: Text(
                  "Artists :${logic.artistText.value}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Date Added : ${logic.selectedMedia!.createdAt.toString()}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: '',
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              " ${logic.selectedMedia!.playsCount} Plays",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: '',
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              " ${logic.selectedMedia!.likesCount} Likes",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: '',
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Text(
            //     "${logic.selectedMedia!.lyrics}",
            //     textAlign: TextAlign.center,
            //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            //         fontFamily: '',
            //         color: Get.isDarkMode ? Colors.white : Colors.black),
            //   ),
            // ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Description: ${logic.selectedMedia!.description.en.toString()}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontFamily: '',
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
            const BottomPlayerWidget()
          ],
        ),
      ),
    );
  }
}
