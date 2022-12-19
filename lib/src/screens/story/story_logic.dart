import 'package:bong/src/config/string_constants.dart';
import 'package:bong/src/core/models/artist_detail_model.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

class StoryLogic extends GetxController {
  late List<Story> currentStory;
  late void Function({Object? returnValue}) action;
  final storyController = StoryController();
  RxList<StoryItem> storyItems = RxList();

  @override
  void onReady() {
    super.onReady();
    setStoriyItems();
  }

  void setStoriyItems() {
    for (Story story in currentStory) {
      if (checkIsImage(story.url)) {
        storyItems.add(StoryItem.pageImage(
            url: "$imageBaseUrlWithoutSlash${story.url}",
            controller: storyController));
      } else {
        storyItems.add(StoryItem.pageVideo(
            "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            controller: storyController));
      }
    }
  }

  bool checkIsImage(String imageUrl) {
    String ii = imageUrl.toLowerCase();
    if (ii.contains('jpeg') ||
        ii.contains('jpg') ||
        ii.contains('png') ||
        ii.contains('gif') ||
        ii.contains('tiff')) {
      return true;
    }
    return false;
  }
}
