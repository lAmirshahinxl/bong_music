import 'package:bong/src/screens/index/index_view.dart';
import 'package:bong/src/screens/login/login_view.dart';
import 'package:bong/src/screens/music/music_view.dart';
import 'package:bong/src/screens/see_all/see_all_view.dart';
import 'package:bong/src/screens/select_artist/select_artist_view.dart';
import 'package:bong/src/screens/setting/setting_view.dart';
import 'package:bong/src/screens/splash/splash_view.dart';
import 'package:flutter/material.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/index':
      return MaterialPageRoute(builder: (_) => IndexPage());
    case '/music':
      return MaterialPageRoute(builder: (_) => const MusicPage());
    case '/setting':
      return MaterialPageRoute(builder: (_) => const SettingPage());
    case '/seeAll':
      return MaterialPageRoute(builder: (_) => const SeeAllPage());
    case '/login':
      return MaterialPageRoute(builder: (_) => LoginPage());
    case '/select_artist':
      return MaterialPageRoute(builder: (_) => const SelectArtistPage());
    default:
      return MaterialPageRoute(builder: (_) => SplashPage());
  }
}
