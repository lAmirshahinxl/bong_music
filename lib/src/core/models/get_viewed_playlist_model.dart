import 'dart:convert';

import 'package:bong/src/core/models/home_requests_model.dart';

GetViewedPlaylist getViewedPlaylistFromJson(String str) =>
    GetViewedPlaylist.fromJson(json.decode(str));

String getViewedPlaylistToJson(GetViewedPlaylist data) =>
    json.encode(data.toJson());

class GetViewedPlaylist {
  GetViewedPlaylist({
    required this.data,
    required this.code,
    required this.message,
  });

  List<PlaylistChild> data;
  int code;
  dynamic message;

  factory GetViewedPlaylist.fromJson(Map<String, dynamic> json) =>
      GetViewedPlaylist(
        data: List<PlaylistChild>.from(
            json["data"].map((x) => PlaylistChild.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}
