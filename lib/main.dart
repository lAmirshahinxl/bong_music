import 'dart:io';
import 'package:bong/src/utils/download_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  Directory directory = await getApplicationDocumentsDirectory();
  GetStorage().write('root', directory.path);
  if (!GetStorage().hasData('theme')) GetStorage().write('theme', 0);
  if (!GetStorage().hasData('language')) GetStorage().write('language', 'en');
  // await DefaultCacheManager().emptyCache();
  // GetStorage().remove('offlineMusic');
  // await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  // FlutterDownloader.registerCallback(DownloadClass.callback);

  // for background music
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
