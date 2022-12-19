import 'package:bong/src/config/color_constants.dart';
import 'package:bong/src/screens/search/search_logic.dart';
import 'package:bong/src/utils/utils.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class Searchpage extends StatelessWidget {
  const Searchpage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SearchLogic());
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: logic.searchController,
                  cursorColor: ColorConstants.gold,
                  onSubmitted: (value) => logic.clickedONSearch(),
                  decoration: defTextfieldDecoration().copyWith(
                      suffixIcon: IconButton(
                        onPressed: logic.clickedONSearch,
                        icon: Icon(
                          Icons.search_rounded,
                          size: 30,
                          color: ColorConstants.gold,
                        ),
                      ),
                      labelText: "Artists, Sings, ...",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Colors.black)),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Get.bottomSheet(selectTypeBottomsheet());
                  },
                  icon: Icon(
                    Icons.media_bluetooth_on_rounded,
                    size: 30,
                    color: ColorConstants.gold,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () {
            if (logic.getSearchModel.value == null) {
              return Expanded(
                child: Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xffFFD700),
                    size: 25,
                  ),
                ),
              );
            }
            if (logic.searchList.isEmpty) {
              return Expanded(
                child: Center(
                    child: Text(
                  "Not Found Any Item",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                )),
              );
            }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: logic.searchList.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      columnCount: 2,
                      position: index,
                      duration: const Duration(seconds: 1),
                      child: SlideAnimation(
                        verticalOffset: 500,
                        horizontalOffset: 0,
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstants.cardbackground,
                          child: InkWell(
                            onTap: () => logic.clickedOnItem(index),
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                                child: Text(
                              logic.searchList[index].title.toString(),
                              style: Theme.of(context).textTheme.headline3,
                            )),
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      childAspectRatio: 12 / 7,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget selectTypeBottomsheet() {
    return Container(
      height: Get.height * 0.3,
      decoration: BoxDecoration(
          color: Get.isDarkMode
              ? const Color.fromARGB(255, 45, 45, 45)
              : Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 100,
          height: 2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
