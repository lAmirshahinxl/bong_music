import 'dart:convert';

import 'artist_detail_model.dart';

HomeRequestModel homeRequestModelFromJson(String str) =>
    HomeRequestModel.fromJson(json.decode(str));

String homeRequestModelToJson(HomeRequestModel data) =>
    json.encode(data.toJson());

class HomeRequestModel {
  HomeRequestModel({
    required this.data,
    required this.code,
    required this.message,
  });

  Data data;
  int code;
  dynamic message;

  factory HomeRequestModel.fromJson(Map<String, dynamic> json) =>
      HomeRequestModel(
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
    required this.stories,
    required this.media,
    required this.playlists,
    required this.artists,
    required this.forYou,
  });

  List<Story> stories;
  List<Media> media;
  List<Playlist> playlists;
  List<Artist> artists;
  List<MediaChild> forYou;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stories: json["stories"] == null
            ? []
            : List<Story>.from(json["stories"].map((x) => Story.fromJson(x))),
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        playlists: json["playlists"] == null
            ? []
            : List<Playlist>.from(
                json["playlists"].map((x) => Playlist.fromJson(x))),
        artists: json["artists"] == null
            ? []
            : List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        forYou: json["foryou"] == null
            ? []
            : List<MediaChild>.from(
                json["foryou"].map((x) => MediaChild.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "playlists": List<dynamic>.from(playlists.map((x) => x.toJson())),
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
      };
}

class Artist {
  Artist({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.mobileNumber,
    required this.mobileVerified,
    required this.isVerified,
    required this.active,
    required this.language,
    required this.notification,
    required this.meta,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.viewsCount,
    required this.likesCount,
  });

  int id;
  String name;
  String email;
  dynamic username;
  String mobileNumber;
  int mobileVerified;
  int isVerified;
  int active;
  String language;
  dynamic notification;
  dynamic meta;
  dynamic rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  String imageUrl;
  int viewsCount;
  int likesCount;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        mobileNumber: json["mobile_number"],
        mobileVerified: json["mobile_verified"],
        isVerified: json["is_verified"],
        active: json["active"],
        language: json["language"],
        notification: json["notification"],
        meta: json["meta"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
        viewsCount: json["views_count"],
        likesCount: json["likes_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "mobile_number": mobileNumber,
        "mobile_verified": mobileVerified,
        "is_verified": isVerified,
        "active": active,
        "language": language,
        "notification": notification,
        "meta": meta,
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image_url": imageUrl,
        "views_count": viewsCount,
        "likes_count": likesCount,
      };
}

class MetaMeta {
  MetaMeta({
    required this.bio,
    required this.dateOfBirth,
    required this.instagramId,
    required this.facebookId,
    required this.twitterId,
  });

  String bio;
  String dateOfBirth;
  String instagramId;
  String facebookId;
  String twitterId;

  factory MetaMeta.fromJson(Map<String, dynamic> json) => MetaMeta(
        bio: json["bio"],
        dateOfBirth: json["date_of_birth"],
        instagramId: json["instagram_id"],
        facebookId: json["facebook_id"],
        twitterId: json["twitter_id"],
      );

  Map<String, dynamic> toJson() => {
        "bio": bio,
        "date_of_birth": dateOfBirth,
        "instagram_id": instagramId,
        "facebook_id": facebookId,
        "twitter_id": twitterId,
      };
}

class Media {
  Media({
    required this.id,
    required this.title,
    required this.children,
  });

  int? id;
  Title title;
  List<MediaChild> children;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        title: json["title"].runtimeType == String
            ? Title(en: json["title"])
            : Title.fromJson(json["title"]),
        children: List<MediaChild>.from(
            json["children"].map((x) => MediaChild.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class MediaChild {
  MediaChild({
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
    required this.imageUrl,
    required this.favoritesCount,
    required this.isFavourite,
    required this.seasonCount,
    required this.episodeCount,
    required this.pivot,
    required this.category,
    required this.content,
  });

  int id;
  Title title;
  Title description;
  Title shortDescription;
  List<dynamic> meta;
  int viewsCount;
  int sharesCount;
  String length;
  dynamic language;
  DateTime releaseDate;
  dynamic maturityRating;
  String status;
  dynamic categoryId;
  dynamic userId;
  dynamic parentMediaId;
  DateTime createdAt;
  DateTime updatedAt;
  int price;
  int likesCount;
  String? type;
  String originalSource;
  String imageUrl;
  int favoritesCount;
  bool isFavourite;
  int seasonCount;
  int episodeCount;
  Pivot? pivot;
  List<dynamic> category;
  List<dynamic> content;

  factory MediaChild.fromJson(Map<String, dynamic> json) {
    return MediaChild(
      id: json["id"],
      title: json["title"].runtimeType == String
          ? json["title"]
          : Title.fromJson(json["title"]),
      description: Title.fromJson(json["description"]),
      shortDescription: Title.fromJson(json["short_description"]),
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
      originalSource: json["original_source"] ?? '',
      imageUrl: json["image_url"],
      favoritesCount: json["favoritesCount"],
      isFavourite: json["isFavourite"],
      seasonCount: json["seasonCount"],
      episodeCount: json["episode_count"],
      pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      category: List<dynamic>.from(json["category"].map((x) => x)),
      content: List<dynamic>.from(json["content"].map((x) => x)),
    );
  }

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
        "original_source": originalSource.toString(),
        "image_url": imageUrl.toString(),
        "favoritesCount": favoritesCount,
        "isFavourite": isFavourite,
        "seasonCount": seasonCount,
        "episode_count": episodeCount,
        "pivot": pivot?.toJson(),
        "category": List<dynamic>.from(category.map((x) => x)),
        "content": List<dynamic>.from(content.map((x) => x)),
      };
}

class Title {
  Title({
    required this.en,
  });

  String en;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Pivot {
  Pivot({
    required this.categoryId,
    required this.mediaId,
  });

  int categoryId;
  int mediaId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        categoryId: json["category_id"],
        mediaId: json["media_id"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
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
  Title title;
  SubcategoryMeta meta;
  int sortOrder;
  dynamic parentId;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        slug: json["slug"],
        title: Title.fromJson(json["title"]),
        meta: SubcategoryMeta.fromJson(json["meta"]),
        sortOrder: json["sort_order"],
        parentId: json["parent_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
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

class SubcategoryMeta {
  SubcategoryMeta({
    required this.color,
    required this.scope,
  });

  String? color;
  String? scope;

  factory SubcategoryMeta.fromJson(Map<String, dynamic> json) =>
      SubcategoryMeta(
        color: json["color"],
        scope: json["scope"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "scope": scope,
      };
}

class Playlist {
  Playlist({
    required this.id,
    required this.title,
    required this.children,
  });

  int id;
  Title title;
  List<PlaylistChild> children;

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        id: json["id"],
        title: Title.fromJson(json["title"]),
        children: List<PlaylistChild>.from(
            json["children"].map((x) => PlaylistChild.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class PlaylistChild {
  PlaylistChild({
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

  factory PlaylistChild.fromJson(Map<String, dynamic> json) => PlaylistChild(
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
        isLiked: json["isLiked"] ?? false,
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
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.mobileNumber,
    required this.mobileVerified,
    required this.isVerified,
    required this.active,
    required this.language,
    required this.notification,
    required this.meta,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.viewsCount,
  });

  int id;
  String name;
  String email;
  dynamic username;
  String mobileNumber;
  int mobileVerified;
  int isVerified;
  int active;
  String language;
  dynamic notification;
  MetaMeta meta;
  dynamic rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  String imageUrl;
  int viewsCount;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        mobileNumber: json["mobile_number"],
        mobileVerified: json["mobile_verified"],
        isVerified: json["is_verified"],
        active: json["active"],
        language: json["language"],
        notification: json["notification"],
        meta: MetaMeta.fromJson(json["meta"]),
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
        viewsCount: json["views_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "mobile_number": mobileNumber,
        "mobile_verified": mobileVerified,
        "is_verified": isVerified,
        "active": active,
        "language": language,
        "notification": notification,
        "meta": meta.toJson(),
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image_url": imageUrl,
        "views_count": viewsCount,
      };
}
