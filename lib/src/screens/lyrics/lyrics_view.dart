import 'package:bong/src/config/color_constants.dart';
import 'package:bong/src/screens/lyrics/lyrics_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

class LyricsPage extends StatefulWidget {
  const LyricsPage({super.key});

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  final logic = Get.put(LyricsLogic());

  @override
  void dispose() {
    Get.delete<LyricsLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Get.isDarkMode ? ColorConstants.backgroundColor : Colors.white,
      child: Column(
        children: [
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
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        logic.indexLogic.selectedMusic.value!.title.en
                            .toString(),
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
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Text(
              logic.indexLogic.selectedMusic.value!.lyrics.toString(),
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'iran'),
            ),
          )
        ],
      ),
    );
  }
}
