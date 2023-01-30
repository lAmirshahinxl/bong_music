import 'dart:convert';

import 'package:get/get.dart';

GetCategoriesModel getCategoriesModelFromJson(String str) =>
    GetCategoriesModel.fromJson(json.decode(str));

String getCategoriesModelToJson(GetCategoriesModel data) =>
    json.encode(data.toJson());

class GetCategoriesModel {
  GetCategoriesModel({
    required this.data,
    required this.code,
    required this.message,
  });

  List<Category> data;
  int code;
  dynamic message;

  factory GetCategoriesModel.fromJson(Map<String, dynamic> json) =>
      GetCategoriesModel(
        data:
            List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class Category {
  Category({
    required this.id,
    required this.slug,
    required this.title,
    required this.sortOrder,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String slug;
  Title title;
  int sortOrder;
  int parentId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        slug: json["slug"],
        title: Title.fromJson(json["title"]),
        sortOrder: json["sort_order"],
        parentId: json["parent_id"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title.toJson(),
        "sort_order": sortOrder,
        "parent_id": parentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Title {
  Title({
    required this.en,
  });

  String en;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        en: json["en"].toString().capitalize!,
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}
