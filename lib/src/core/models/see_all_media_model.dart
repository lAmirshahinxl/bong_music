import 'dart:convert';

import 'package:bong/src/core/models/home_requests_model.dart';

SeeAllMediaModel seeAllMediaModelFromJson(String str) =>
    SeeAllMediaModel.fromJson(json.decode(str));

String seeAllMediaModelToJson(SeeAllMediaModel data) =>
    json.encode(data.toJson());

class SeeAllMediaModel {
  SeeAllMediaModel({
    required this.data,
    required this.code,
    required this.message,
  });

  List<MediaChild> data;
  int code;
  String message;

  factory SeeAllMediaModel.fromJson(Map<String, dynamic> json) =>
      SeeAllMediaModel(
        data: json["data"] == null
            ? []
            : List<MediaChild>.from(
                json["data"].map((x) => MediaChild.fromJson(x))),
        code: json["code"],
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "code": code,
        "message": message,
      };
}
