import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/screens/media_info/media_info_logic.dart';
import 'package:bong/src/widgets/bottom_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

class MediaInfoPage extends StatefulWidget {
  const MediaInfoPage({super.key});

  @override
  State<MediaInfoPage> createState() => _MediaInfoPageState();
}

class _MediaInfoPageState extends State<MediaInfoPage> {
  final logic = Get.put(MediaInfoLogic());

  @override
  void dispose() {
    Get.delete<MediaInfoLogic>();
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
          Obx(
            () => Text(
              "Song : ${logic.musicLogic.detailMediaModel.value!.data.title.en.toString()}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Text(
              "Artists : ${logic.artistText.value}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Obx(
          //   () => Text(
          //     "Date Added : ${logic.musicLogic.detailMediaModel.value!.data.createdAt.toString()}",
          //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          //         fontFamily: '',
          //         color: Get.isDarkMode ? Colors.white : Colors.black),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Text(
              " ${logic.musicLogic.detailMediaModel.value!.data.playsCount} Plays",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: '',
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Text(
              " ${logic.musicLogic.detailMediaModel.value!.data.likesCount} Likes",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: '',
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Expanded(
              child: Text(
                "Description: ${logic.musicLogic.detailMediaModel.value!.data.description.en.toString()}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontFamily: '',
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          ),
          // const BottomPlayerWidget()
        ],
      ),
    );
  }
}
