import 'dart:convert';

import 'package:bong/src/core/models/home_requests_model.dart';

GetNewMusicModel getArtistModelFromJson(String str) =>
    GetNewMusicModel.fromJson(json.decode(str));

String getArtistModelToJson(GetNewMusicModel data) =>
    json.encode(data.toJson());

class GetNewMusicModel {
  GetNewMusicModel({
    required this.data,
    required this.code,
    required this.message,
  });

  List<MediaChild> data;
  int code;
  String? message;

  factory GetNewMusicModel.fromJson(Map<String, dynamic> json) =>
      GetNewMusicModel(
        data: List<MediaChild>.from(
            json["data"].map((x) => MediaChild.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}
