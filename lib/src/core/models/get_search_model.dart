import 'dart:convert';

import 'package:get/get.dart';

GetSearchModel getSearchModelFromJson(String str) =>
    GetSearchModel.fromJson(json.decode(str));

String getSearchModelToJson(GetSearchModel data) => json.encode(data.toJson());

class GetSearchModel {
  GetSearchModel({
    required this.data,
    required this.code,
    required this.message,
  });

  List<Search> data;
  int code;
  dynamic message;

  factory GetSearchModel.fromJson(Map<String, dynamic> json) => GetSearchModel(
        data: List<Search>.from(json["data"].map((x) => Search.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class Search {
  Search({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        id: json["id"],
        title: json["title"].toString().capitalize!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
