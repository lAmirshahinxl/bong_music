import 'dart:convert';

import 'package:bong/src/core/models/home_requests_model.dart';

GetArtistModel getArtistModelFromJson(String str) =>
    GetArtistModel.fromJson(json.decode(str));

String getArtistModelToJson(GetArtistModel data) => json.encode(data.toJson());

class GetArtistModel {
  GetArtistModel({
    required this.data,
    required this.code,
    required this.message,
  });

  List<Artist> data;
  int code;
  String? message;

  factory GetArtistModel.fromJson(Map<String, dynamic> json) => GetArtistModel(
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
