import 'package:bong/src/screens/index/index_view.dart';
import 'package:bong/src/screens/latest_artist/latest_artist_view.dart';
import 'package:bong/src/screens/latest_podcast/latest_podcast_view.dart';
import 'package:bong/src/screens/login/login_view.dart';
import 'package:bong/src/screens/media_info/media_info_view.dart';
import 'package:bong/src/screens/music/music_view.dart';
import 'package:bong/src/screens/music_videos/music_videos_view.dart';
import 'package:bong/src/screens/new_music/new_music_view.dart';
import 'package:bong/src/screens/see_all/see_all_view.dart';
import 'package:bong/src/screens/select_artist/select_artist_view.dart';
import 'package:bong/src/screens/setting/setting_view.dart';
import 'package:bong/src/screens/splash/splash_view.dart';
import 'package:bong/src/screens/suggest_login/suggest_login_view.dart';
import 'package:bong/src/screens/upcoming_events/upcoming_events_view.dart';
import 'package:bong/src/screens/viewed_podcast/viewed_podcast_view.dart';
import 'package:flutter/material.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/index':
      return MaterialPageRoute(builder: (_) => IndexPage());
    case '/music':
      return MaterialPageRoute(builder: (_) => MusicPage());
    case '/setting':
      return MaterialPageRoute(builder: (_) => const SettingPage());
    case '/seeAll':
      return MaterialPageRoute(builder: (_) => const SeeAllPage());
    case '/login':
      return MaterialPageRoute(builder: (_) => LoginPage());
    case '/select_artist':
      return MaterialPageRoute(builder: (_) => const SelectArtistPage());
    case '/new_music':
      return MaterialPageRoute(builder: (_) => const NewMusicPage());
    case '/music_videos':
      return MaterialPageRoute(builder: (_) => const MusicVideosPage());
    case '/latest_podcast':
      return MaterialPageRoute(builder: (_) => const LatestPodcastPage());
    case '/latest_artist':
      return MaterialPageRoute(builder: (_) => const LatestArtistPage());
    case '/viewed_podcast':
      return MaterialPageRoute(builder: (_) => const ViewedPodcastPage());
    case '/upcoming_events':
      return MaterialPageRoute(builder: (_) => const UpComingEventsPage());
    case '/media_info':
      return MaterialPageRoute(builder: (_) => const MediaInfoPage());
    case '/suggest':
      return MaterialPageRoute(builder: (_) => const SuggestLoginPage());
    default:
      return MaterialPageRoute(builder: (_) => SplashPage());
  }
}
