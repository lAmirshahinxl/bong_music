import 'package:bong/src/core/models/artist_detail_model.dart';
import 'package:bong/src/screens/story/story_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

class Storypage extends StatefulWidget {
  late void Function({Object? returnValue}) action;
  late List<Story> currentStory;

  Storypage(this.action, this.currentStory, {super.key});

  @override
  State<Storypage> createState() => _StorypageState();
}

class _StorypageState extends State<Storypage> {
  final logic = Get.put(StoryLogic());

  @override
  void dispose() {
    Get.delete<StoryLogic>();
    super.dispose();
  }

  @override
  void initState() {
    logic.currentStory = widget.currentStory;
    logic.action = widget.action;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
        storyItems: logic.storyItems,
        controller: logic.storyController,
        repeat: false,
        onStoryShow: (s) {},
        onComplete: () => Get.back(),
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Get.back();
          }
        });
  }
}
