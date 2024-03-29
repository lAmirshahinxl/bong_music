import 'dart:convert';
import 'dart:io';

import 'package:bong/src/core/models/artist_detail_model.dart';
import 'package:bong/src/core/models/category_childs_model.dart';
import 'package:bong/src/core/models/get_artist_model.dart';
import 'package:bong/src/core/models/get_category_model.dart';
import 'package:bong/src/core/models/get_latest_artist_model.dart';
import 'package:bong/src/core/models/get_new_music_model.dart';
import 'package:bong/src/core/models/get_search_model.dart';
import 'package:bong/src/core/models/get_upcoming_events_model.dart';
import 'package:bong/src/core/models/get_viewed_playlist_model.dart';
import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:bong/src/core/models/login_model.dart';
import 'package:bong/src/core/models/playlist_detail_model.dart';
import 'package:bong/src/core/models/see_all_media_model.dart';
import 'package:bong/src/core/models/toggle_favorite_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
import '../../config/string_constants.dart';
import '../models/detail_media_model.dart';

class RemoteService {
  late Dio dio;
  static late CookieJar cookieJar;

  RemoteService() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    dio = Dio(options);
    // if (!kIsWeb) {
    //   cookieJar = PersistCookieJar(
    //       ignoreExpires: true, storage: FileStorage(GetStorage().read('root') + "/.cookies/"));
    //   dio.interceptors.add(CookieManager(cookieJar));
    // }
  }

  // one element is data
  // second element is error
  Future<List> homeRequests() async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response =
          await dio.get('/app/home', options: Options(headers: header));
      return [HomeRequestModel.fromJson(response.data), null];
    } on DioError catch (e) {
      print(e.toString());
      return [null, "Error Data"];
    }
  }

  Future<List> exploreRequest() async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response =
          await dio.get('/app/explore', options: Options(headers: header));
      return [HomeRequestModel.fromJson(response.data), null];
    } on DioError catch (e) {
      print(e.toString());
      return [null, "Error Data"];
    }
  }

  Future<List> playListDetail(int playListId) async {
    try {
      var header = {"Authorization": "Bearer ${GetStorage().read("token")}"};
      var response = await dio.get('/app/playlists/$playListId',
          options: Options(headers: header));
      return [PlayListDetailModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getPlaylistChildCategory(int parentCategoryId) async {
    try {
      var header = {"Authorization": "Bearer ${GetStorage().read("token")}"};
      var response = await dio.get('/app/playlists',
          queryParameters: {'category_id': parentCategoryId},
          options: Options(headers: header));
      return [CatgeoryChildsModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getArtistDetail(int artistId) async {
    try {
      var header = {"Authorization": "Bearer ${GetStorage().read("token")}"};
      print('/app/artists/$artistId');
      var response = await dio.get('/app/artists/$artistId',
          options: Options(headers: header));
      return [ArtistDetailModel.fromJson(response.data), null];
    } on DioError catch (e) {
      print(e.toString());
      return [null, "Error Data"];
    }
  }

  Future<List> toggleFavorite(int idd, String type) async {
    try {
      var header = {"Authorization": "Bearer ${GetStorage().read("token")}"};
      var body = {"id": idd, "type": type};
      var response = await dio.post('/app/favorite/toggle',
          data: body, options: Options(headers: header));
      return [ToggleFavoriteModel.fromJson(response.data), null];
    } on DioError catch (e) {
      print(e.toString());
      return [null, "Error Data"];
    }
  }

  Future<List> incrasePlay(int idd) async {
    try {
      var header = {"Authorization": "Bearer ${GetStorage().read("token")}"};
      var body = {"media_id": idd};

      var response = await dio.post('/app/media/play/increase',
          data: body, options: Options(headers: header));

      if (response.statusCode == 200) {
        return [true, null];
      } else {
        return [null, "Error Auth"];
      }
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getSeeAllMedia(String categoryId, String searchType) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      print("/app/media?sort=$searchType&category_id=$categoryId");
      var response =
          await dio.get('/app/media?sort=$searchType&category_id=$categoryId');
      return [SeeAllMediaModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> login(String email, String password) async {
    try {
      var body = {"email": email, "password": password};
      var response = await dio.post('/app/login', data: body);
      return [LoginModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, e.response?.data['message'] ?? "Error Login"];
    }
  }

  Future<bool> register(String email, String password, String mobile,
      String name, String birthday) async {
    try {
      var body = {
        "name": name,
        "email": email,
        "mobile_number": mobile,
        "password": password,
        "birthday": birthday,
        "language": "en"
      };
      print(body);
      var header = {"Accept": "application/json, text/plain, */*"};
      await dio.post('/app/register',
          data: body, options: Options(headers: header));
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List> getArtists() async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response =
          await dio.get('/app/artists', options: Options(headers: header));
      return [GetArtistModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getCategoreis({int? parentId}) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response = await dio.get('/app/categories',
          queryParameters: {
            'parent_id': parentId == null ? '' : parentId.toString()
          },
          options: Options(headers: header));
      return [GetCategoriesModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getMediaDetail(int mediaId) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response = await dio.get('/app/media/$mediaId',
          options: Options(headers: header));
      return [DetailMediaModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getSearch(String word, String type) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response = await dio.get('/app/search?term=$word&in=$type',
          options: Options(headers: header));
      return [GetSearchModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getNewMusicList(int page) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response = await dio.get('/app/media?sort=latest&page=$page',
          options: Options(headers: header));
      return [GetNewMusicModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getMusicVideos(int page) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response = await dio.get('/app/media?page=$page&filter=musicvideo',
          options: Options(headers: header));
      return [GetNewMusicModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getLatestPodcasts(int page) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response = await dio.get(
          '/app/media?sort=latest&page=$page&filter=podcast',
          options: Options(headers: header));
      return [GetNewMusicModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getViewedArtist(int page) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response = await dio.get('/app/artists/viewed',
          options: Options(headers: header));
      return [GetLatestArtistModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getViewdPlaylist(int page) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response = await dio.get('/app/playlists/viewed',
          options: Options(headers: header));
      return [GetViewedPlaylist.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getViewedMedia(int page) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response =
          await dio.get('/app/media/viewed', options: Options(headers: header));
      return [GetNewMusicModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getUpcomingEvents() async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response = await dio.get('/app/upcoming-events',
          options: Options(headers: header));
      return [GetUpcomingEventsModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }
}
