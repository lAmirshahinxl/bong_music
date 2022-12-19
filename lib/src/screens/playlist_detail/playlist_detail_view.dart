import 'package:bong/src/screens/playlist_detail/playlist_detail_logic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_constants.dart';
import '../../config/string_constants.dart';
import '../../core/models/home_requests_model.dart';
import '../../widgets/bottom_player.dart';

class PlayListDeatilPage extends StatefulWidget {
  late void Function({Object? returnValue}) action;
  late PlaylistChild currenPlayList;

  PlayListDeatilPage(this.action, this.currenPlayList, {super.key});

  @override
  State<PlayListDeatilPage> createState() => _PlayListDeatilPageState();
}

class _PlayListDeatilPageState extends State<PlayListDeatilPage> {
  final logic = Get.put(PlayListDetailLogic());

  @override
  void initState() {
    logic.currenPlayList = widget.currenPlayList.obs;
    logic.action = widget.action;
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<PlayListDetailLogic>();
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
                        onPressed: () => logic.action.call(),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      logic.currenPlayList.value.title.toString(),
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                            width: Get.width * 0.25,
                            height: Get.width * 0.25,
                            imageUrl:
                                '$imageBaseUrl/${logic.currenPlayList.value.imageUrl}',
                            fit: BoxFit.fill),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                logic.currenPlayList.value.title.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${logic.currenPlayList.value.followers} Followers',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: ''),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'By Bong Music',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => logic.addToFavorite(),
                                  icon: Obx(
                                    () => Icon(
                                      logic.currenPlayList.value.isLiked
                                          ? Icons.star_rounded
                                          : Icons.star_outline_rounded,
                                      size: 25,
                                      color: logic.currenPlayList.value.isLiked
                                          ? ColorConstants.gold
                                          : Colors.white,
                                    ),
                                  )),
                              IconButton(
                                  onPressed: () => logic.downloadPlayList(),
                                  icon: Icon(
                                    Icons.download_rounded,
                                    size: 25,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text("${logic.currenPlayList.value.title} on Bong Music"),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Obx(
                    () {
                      if (logic.detailModel.value == null) {
                        return Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 60, 60, 60),
                          highlightColor: Colors.white.withOpacity(0.02),
                          child: ListView.builder(
                            itemCount: 3,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, idx) {
                              return AnimationConfiguration.staggeredList(
                                position: idx,
                                duration: const Duration(seconds: 1),
                                child: SlideAnimation(
                                  verticalOffset: 500,
                                  child: Container(
                                    height: 100,
                                    width: Get.width,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 60, 60, 60),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: logic.detailModel.value!.data.media.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, idx) {
                            return itemChildPlayList(idx);
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        const BottomPlayerWidget()
      ]),
    );
  }

  Widget itemChildPlayList(int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(seconds: 1),
      child: FadeInAnimation(
        duration: const Duration(seconds: 1),
        child: GestureDetector(
          onTap: () => logic.goToMusicPage(MediaChild.fromJson(
              logic.detailModel.value!.data.media[index].toJson())),
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
                          color: Get.isDarkMode ? Colors.white : Colors.black),
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
                              '$imageBaseUrl/${logic.detailModel.value!.data.imageUrl}'),
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
                      logic.detailModel.value!.data.media[index].title.en
                          .toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      logic.detailModel.value!.data.media[index].description.en
                          .toString(),
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
