import 'dart:convert';

import 'package:bong/src/core/models/artist_detail_model.dart';

DetailMediaModel detailMediaModelFromJson(String str) =>
    DetailMediaModel.fromJson(json.decode(str));

String detailMediaModelToJson(DetailMediaModel data) =>
    json.encode(data.toJson());

class DetailMediaModel {
  DetailMediaModel({
    required this.data,
    required this.code,
    required this.message,
  });

  Data data;
  int code;
  dynamic message;

  factory DetailMediaModel.fromJson(Map<String, dynamic> json) =>
      DetailMediaModel(
        data: Data.fromJson(json["data"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "code": code,
        "message": message,
      };
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.meta,
    required this.viewsCount,
    required this.sharesCount,
    required this.length,
    required this.language,
    required this.releaseDate,
    required this.maturityRating,
    required this.status,
    required this.userId,
    required this.parentMediaId,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.likesCount,
    required this.type,
    required this.originalSource,
    required this.imageUrl,
    required this.stories,
    required this.upNext,
    required this.favoritesCount,
    required this.isFavourite,
    required this.seasonCount,
    required this.episodeCount,
    required this.category,
    required this.content,
  });

  int id;
  Description title;
  Description description;
  Description shortDescription;
  List<dynamic> meta;
  int viewsCount;
  int sharesCount;
  String length;
  dynamic language;
  DateTime releaseDate;
  dynamic maturityRating;
  String status;
  dynamic userId;
  dynamic parentMediaId;
  DateTime createdAt;
  DateTime updatedAt;
  int price;
  int likesCount;
  String type;
  String originalSource;
  String imageUrl;
  List<Story> stories;
  List<Data> upNext;
  int favoritesCount;
  bool isFavourite;
  int seasonCount;
  int episodeCount;
  List<Category> category;
  List<dynamic> content;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: Description.fromJson(json["title"]),
        description: Description.fromJson(json["description"]),
        shortDescription: Description.fromJson(json["short_description"]),
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
        viewsCount: json["views_count"],
        sharesCount: json["shares_count"],
        length: json["length"],
        language: json["language"],
        releaseDate: DateTime.parse(json["release_date"]),
        maturityRating: json["maturity_rating"],
        status: json["status"],
        userId: json["user_id"],
        parentMediaId: json["parent_media_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        price: json["price"],
        likesCount: json["likes_count"],
        type: json["type"],
        originalSource: json["original_source"] ?? "",
        imageUrl: json["image_url"],
        stories: json["stories"] == null
            ? []
            : List<Story>.from(json["stories"].map((x) => x)),
        upNext: json["up_next"] == null
            ? []
            : List<Data>.from(json["up_next"].map((x) => Data.fromJson(x))),
        favoritesCount: json["favoritesCount"],
        isFavourite: json["isFavourite"],
        seasonCount: json["seasonCount"],
        episodeCount: json["episode_count"],
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        content: List<dynamic>.from(json["content"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "description": description.toJson(),
        "short_description": shortDescription.toJson(),
        "meta": List<dynamic>.from(meta.map((x) => x)),
        "views_count": viewsCount,
        "shares_count": sharesCount,
        "length": length,
        "language": language,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "maturity_rating": maturityRating,
        "status": status,
        "user_id": userId,
        "parent_media_id": parentMediaId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "price": price,
        "likes_count": likesCount,
        "type": type,
        "original_source": originalSource,
        "image_url": imageUrl,
        "stories": List<Story>.from(stories.map((x) => x)),
        "up_next": List<dynamic>.from(upNext.map((x) => x.toJson())),
        "favoritesCount": favoritesCount,
        "isFavourite": isFavourite,
        "seasonCount": seasonCount,
        "episode_count": episodeCount,
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "content": List<dynamic>.from(content.map((x) => x)),
      };
}

class Category {
  Category(
      {required this.id,
      required this.title,
      required this.sortOrder,
      required this.parentId,
      required this.createdAt,
      required this.updatedAt});

  int id;
  Description title;
  int sortOrder;
  dynamic parentId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: Description.fromJson(json["title"]),
        sortOrder: json["sort_order"],
        parentId: json["parent_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "sort_order": sortOrder,
        "parent_id": parentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
