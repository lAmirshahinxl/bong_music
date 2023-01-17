import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:bong/src/screens/new_music/new_music_logic.dart';
import 'package:bong/src/widgets/bottom_player.dart';
import 'package:bong/src/widgets/network_aware_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../config/string_constants.dart';

class NewMusicPage extends StatefulWidget {
  const NewMusicPage({super.key});

  @override
  State<NewMusicPage> createState() => _NewMusicPageState();
}

class _NewMusicPageState extends State<NewMusicPage> {
  final logic = Get.put(NewMusicLogic());

  @override
  void dispose() {
    Get.delete<NewMusicLogic>();
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
                        : ListView.builder(
                            itemCount: logic.mediaList.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return itemMusic(index);
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

  Widget itemMusic(int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(seconds: 1),
      child: FadeInAnimation(
        duration: const Duration(seconds: 1),
        child: GestureDetector(
          onTap: () => logic.goToMusicPage(logic.mediaList[index]),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Container(
                  width: Get.width * 0.15,
                  height: Get.width * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              '$imageBaseUrl/${logic.mediaList[index].imageUrl}'),
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
                      logic.mediaList[index].title.en.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      logic.mediaList[index].description.en.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
