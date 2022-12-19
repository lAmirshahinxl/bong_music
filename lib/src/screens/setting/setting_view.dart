import 'package:bong/src/screens/setting/setting_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../config/color_constants.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final logic = Get.put(SettingLogic());

  @override
  void dispose() {
    Get.delete<SettingLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: 'setting8',
            child: FittedBox(
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
                              logic.splashLogic.currentLanguage['setting'],
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
          ),
          // setting
          Material(
            child: InkWell(
              onTap: () {
                Get.bottomSheet(
                  selectlanguageBottomsheet(),
                );
              },
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.language_rounded,
                              size: 25,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                logic.splashLogic
                                    .currentLanguage['changeLanguage'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            )
                          ],
                        ),
                        RotatedBox(
                          quarterTurns: 270,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 15,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  )
                ],
              ),
            ),
          ),
          Material(
            child: InkWell(
              onTap: () => logic.changeTheme(),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.color_lens_rounded,
                              size: 25,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                logic
                                    .splashLogic.currentLanguage['changeTheme'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            )
                          ],
                        ),
                        RotatedBox(
                          quarterTurns: 270,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 15,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectlanguageBottomsheet() {
    return Container(
      height: Get.height * 0.3,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? ColorConstants.backgroundColor : Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000), color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            color: Get.isDarkMode ? null : Colors.white,
            child: InkWell(
              onTap: () {
                logic.splashLogic.changeLanguage('en');
                logic.splashLogic.currentLanguage.refresh();
                Get.back();
              },
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.language_rounded,
                              size: 25,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "English",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  )
                ],
              ),
            ),
          ),
          Material(
            color: Get.isDarkMode ? null : Colors.white,
            child: InkWell(
              onTap: () {
                logic.splashLogic.changeLanguage('ar');
                logic.splashLogic.currentLanguage.refresh();
                Get.back();
              },
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.language_rounded,
                              size: 25,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Arabic",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  )
                ],
              ),
            ),
          ),
          Material(
            color: Get.isDarkMode ? null : Colors.white,
            child: InkWell(
              onTap: () {
                logic.splashLogic.changeLanguage('tr');
                logic.splashLogic.currentLanguage.refresh();
                Get.back();
              },
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.language_rounded,
                              size: 25,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Turkish",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
