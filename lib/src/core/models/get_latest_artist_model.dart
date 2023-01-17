import 'dart:convert';

import 'package:bong/src/core/models/home_requests_model.dart';

GetLatestArtistModel getLatestArtistFromJson(String str) =>
    GetLatestArtistModel.fromJson(json.decode(str));

String getLatestArtistToJson(GetLatestArtistModel data) =>
    json.encode(data.toJson());

class GetLatestArtistModel {
  GetLatestArtistModel({
    required this.data,
    required this.code,
    required this.message,
  });

  List<Artist> data;
  int code;
  dynamic message;

  factory GetLatestArtistModel.fromJson(Map<String, dynamic> json) =>
      GetLatestArtistModel(
        data: List<Artist>.from(json["data"].map((x) => Artist.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}
