import 'package:bong/src/screens/favorites/favorites_logic.dart';
import 'package:bong/src/widgets/network_aware_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

class FavoritsPage extends StatefulWidget {
  const FavoritsPage({super.key});

  @override
  State<FavoritsPage> createState() => _FavoritsPageState();
}

class _FavoritsPageState extends State<FavoritsPage> {
  final logic = Get.put(FavoritsLogic());

  @override
  void dispose() {
    Get.delete<FavoritsLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAwareWidget(
          onlineWidget: Column(
        children: [
          Hero(
            tag: 'setting6',
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
                              logic.splashLogic.currentLanguage['favorite'],
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
          Expanded(
            child: Center(
                child: Text(
              "Not Found Any Item",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            )),
          )
        ],
      )),
    );
  }
}
