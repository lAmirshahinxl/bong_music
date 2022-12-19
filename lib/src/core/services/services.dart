import 'dart:convert';
import 'dart:io';

import 'package:bong/src/core/models/artist_detail_model.dart';
import 'package:bong/src/core/models/get_artist_model.dart';
import 'package:bong/src/core/models/get_category_model.dart';
import 'package:bong/src/core/models/get_search_model.dart';
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
      var response = await dio.get('/app/playlists/$playListId');
      return [PlayListDetailModel.fromJson(response.data), null];
    } on DioError catch (e) {
      return [null, "Error Data"];
    }
  }

  Future<List> getArtistDetail(int artistId) async {
    try {
      var response = await dio.get('/app/artists/$artistId');
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
      print(response.data);
      print('==========');
      return [ToggleFavoriteModel.fromJson(response.data), null];
    } on DioError catch (e) {
      print(e.toString());
      return [null, "Error Data"];
    }
  }

  Future<List> getSeeAllMedia(String categoryId, String searchType) async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
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

  Future<bool> register(
      String email, String password, String mobile, String name) async {
    try {
      var body = {
        "name": name,
        "email": email,
        "mobile_number": mobile,
        "password": password,
        "language": "en"
      };
      print(body);
      var header = {"Accept": "application/json, text/plain, */*"};
      await dio.post('/app/register',
          data: body, options: Options(headers: header));
      return true;
    } on DioError catch (e) {
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

  Future<List> getCategoreis() async {
    try {
      var header = GetStorage().hasData("token")
          ? {"Authorization": "Bearer ${GetStorage().read("token")}"}
          : null;
      var response =
          await dio.get('/app/categories', options: Options(headers: header));
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

  // Future<List> getMarketAssets() async {
  //   try {
  //     var response = await dio.get('/market/stats?quote_asset=IRT');
  //     MarketStatsModel model = MarketStatsModel.fromJson(response.data);
  //     List<BtCIRT> finalList = [];
  //     model.toJson().forEach((final String key, final value) {
  //       finalList.add(BtCIRT.fromJson(value));
  //     });
  //     return [finalList, null];
  //   } on DioError catch (e) {
  //     if (e.response?.statusCode == 401) {
  //       return [null, 401];
  //     } else {
  //       var error = MarketAssetsErrorModel.fromJson(e.response?.data);
  //       return [null, error.error];
  //     }
  //   }
  // }

}
