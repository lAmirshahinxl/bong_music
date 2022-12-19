import 'dart:convert';

PlayListDetailModel playListDetailModelFromJson(String str) =>
    PlayListDetailModel.fromJson(json.decode(str));

String playListDetailModelToJson(PlayListDetailModel data) =>
    json.encode(data.toJson());

class PlayListDetailModel {
  PlayListDetailModel({
    required this.data,
    required this.code,
    required this.message,
  });

  Data data;
  int code;
  dynamic message;

  factory PlayListDetailModel.fromJson(Map<String, dynamic> json) =>
      PlayListDetailModel(
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
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.creator,
    required this.visibility,
    required this.followers,
    required this.isAlbum,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.likesCount,
    required this.viewsCount,
    required this.isLiked,
    required this.media,
  });

  int id;
  int userId;
  int categoryId;
  String title;
  String description;
  String imageUrl;
  String creator;
  String visibility;
  int followers;
  int isAlbum;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  int likesCount;
  int viewsCount;
  bool isLiked;
  List<Media> media;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["image_url"],
        creator: json["creator"],
        visibility: json["visibility"],
        followers: json["followers"],
        isAlbum: json["isAlbum"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        likesCount: json["likes_count"],
        viewsCount: json["views_count"],
        isLiked: json["isLiked"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category_id": categoryId,
        "title": title,
        "description": description,
        "image_url": imageUrl,
        "creator": creator,
        "visibility": visibility,
        "followers": followers,
        "isAlbum": isAlbum,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "likes_count": likesCount,
        "views_count": viewsCount,
        "isLiked": isLiked,
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
      };
}

class Media {
  Media({
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
    required this.categoryId,
    required this.userId,
    required this.parentMediaId,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.likesCount,
    required this.type,
    required this.originalSource,
    required this.favoritesCount,
    required this.isFavourite,
    required this.seasonCount,
    required this.episodeCount,
    required this.pivot,
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
  int categoryId;
  dynamic userId;
  dynamic parentMediaId;
  DateTime createdAt;
  DateTime updatedAt;
  int price;
  int likesCount;
  String type;
  String originalSource;
  int favoritesCount;
  bool isFavourite;
  int seasonCount;
  int episodeCount;
  MediaPivot pivot;
  List<dynamic> category;
  List<dynamic> content;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
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
        categoryId: json["category_id"],
        userId: json["user_id"],
        parentMediaId: json["parent_media_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        price: json["price"],
        likesCount: json["likes_count"],
        type: json["type"],
        originalSource: json["original_source"],
        favoritesCount: json["favoritesCount"],
        isFavourite: json["isFavourite"],
        seasonCount: json["seasonCount"],
        episodeCount: json["episode_count"],
        pivot: MediaPivot.fromJson(json["pivot"]),
        category: List<dynamic>.from(json["category"].map((x) => x)),
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
        "category_id": categoryId,
        "user_id": userId,
        "parent_media_id": parentMediaId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "price": price,
        "likes_count": likesCount,
        "type": type,
        "original_source": originalSource,
        "favoritesCount": favoritesCount,
        "isFavourite": isFavourite,
        "seasonCount": seasonCount,
        "episode_count": episodeCount,
        "pivot": pivot.toJson(),
        "category": List<dynamic>.from(category.map((x) => x)),
        "content": List<dynamic>.from(content.map((x) => x)),
      };
}

class Description {
  Description({
    required this.en,
  });

  String en;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class MediaPivot {
  MediaPivot({
    required this.playlistId,
    required this.mediaId,
  });

  int playlistId;
  int mediaId;

  factory MediaPivot.fromJson(Map<String, dynamic> json) => MediaPivot(
        playlistId: json["playlist_id"],
        mediaId: json["media_id"],
      );

  Map<String, dynamic> toJson() => {
        "playlist_id": playlistId,
        "media_id": mediaId,
      };
}

class Subcategory {
  Subcategory({
    required this.id,
    required this.slug,
    required this.title,
    required this.meta,
    required this.sortOrder,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  int id;
  String slug;
  Description title;
  Meta meta;
  int sortOrder;
  dynamic parentId;
  DateTime createdAt;
  DateTime updatedAt;
  SubcategoryPivot pivot;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        slug: json["slug"],
        title: Description.fromJson(json["title"]),
        meta: Meta.fromJson(json["meta"]),
        sortOrder: json["sort_order"],
        parentId: json["parent_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: SubcategoryPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title.toJson(),
        "meta": meta.toJson(),
        "sort_order": sortOrder,
        "parent_id": parentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Meta {
  Meta({
    required this.color,
    required this.scope,
  });

  String color;
  String scope;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        color: json["color"] == null ? null : json["color"],
        scope: json["scope"],
      );

  Map<String, dynamic> toJson() => {
        "color": color == null ? null : color,
        "scope": scope,
      };
}

class SubcategoryPivot {
  SubcategoryPivot({
    required this.mediaId,
    required this.categoryId,
  });

  int mediaId;
  int categoryId;

  factory SubcategoryPivot.fromJson(Map<String, dynamic> json) =>
      SubcategoryPivot(
        mediaId: json["media_id"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "media_id": mediaId,
        "category_id": categoryId,
      };
}
