import 'dart:convert';

import 'package:bong/src/core/models/home_requests_model.dart';
import 'package:get/get.dart';

import 'get_upcoming_events_model.dart';

ArtistDetailModel artistDetailModelFromJson(String str) =>
    ArtistDetailModel.fromJson(json.decode(str));

String artistDetailModelToJson(ArtistDetailModel data) =>
    json.encode(data.toJson());

class ArtistDetailModel {
  ArtistDetailModel({
    required this.data,
    required this.code,
    required this.message,
  });

  Data data;
  int code;
  dynamic message;

  factory ArtistDetailModel.fromJson(Map<String, dynamic> json) =>
      ArtistDetailModel(
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
    required this.stories,
    required this.musics,
    required this.musicVideos,
    required this.podcasts,
    required this.playLists,
    required this.upcomingEvent,
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
  DataMeta? meta;
  dynamic rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  String imageUrl;
  int viewsCount;
  int likesCount;
  List<Story> stories;
  List<Media> musics;
  List<Media> musicVideos;
  List<Media> podcasts;
  List<PlaylistChild> playLists;
  List<EventModel> upcomingEvent;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"].toString().capitalize!,
        email: json["email"],
        username: json["username"],
        mobileNumber: json["mobile_number"],
        mobileVerified: json["mobile_verified"],
        isVerified: json["is_verified"],
        active: json["active"],
        language: json["language"],
        notification: json["notification"],
        meta: json["meta"] == null ? null : DataMeta.fromJson(json["meta"]),
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
        viewsCount: json["views_count"],
        likesCount: json["likes_count"],
        stories:
            List<Story>.from(json["stories"].map((x) => Story.fromJson(x))),
        musics: List<Media>.from(json["musics"].map((x) => Media.fromJson(x))),
        musicVideos: List<Media>.from(
            json["music-videos"].map((x) => Media.fromJson(x))),
        podcasts:
            List<Media>.from(json["podcasts"].map((x) => Media.fromJson(x))),
        playLists: List<PlaylistChild>.from(
            json["playlists"].map((x) => PlaylistChild.fromJson(x))),
        upcomingEvent: List<EventModel>.from(
            json["upcoming-event"].map((x) => EventModel.fromJson(x))),
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
        "meta": meta?.toJson(),
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image_url": imageUrl,
        "views_count": viewsCount,
        "likes_count": likesCount,
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
        "musics": List<dynamic>.from(musics.map((x) => x.toJson())),
        "music-videos": List<dynamic>.from(musicVideos.map((x) => x.toJson())),
        "podcasts": List<dynamic>.from(podcasts.map((x) => x.toJson())),
        "playlists": List<dynamic>.from(playLists.map((x) => x.toJson())),
        "upcoming-event":
            List<dynamic>.from(upcomingEvent.map((x) => x.toJson())),
      };
}

class Media {
  Media({
    required this.id,
    required this.title,
    required this.description,
    required this.shortDescription,
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
    required this.playsCount,
    required this.type,
    required this.originalSource,
    required this.imageUrl,
    required this.lyrics,
    required this.lyricsSplit,
    required this.favoritesCount,
    required this.isFavourite,
    required this.seasonCount,
    required this.episodeCount,
    required this.category,
    required this.content,
    required this.pivot,
    required this.artists,
    required this.upcomingEvents,
  });

  int id;
  Description title;
  Description description;
  Description shortDescription;
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
  int playsCount;
  String type;
  String originalSource;
  String imageUrl;
  dynamic lyrics;
  dynamic lyricsSplit;
  int favoritesCount;
  bool isFavourite;
  int seasonCount;
  int episodeCount;
  List<dynamic> category;
  List<dynamic> content;
  List<Artist> artists;
  List<EventModel> upcomingEvents;
  MediaPivot? pivot;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        title: Description.fromJson(json["title"]),
        description: Description.fromJson(json["description"]),
        shortDescription: Description.fromJson(json["short_description"]),
        viewsCount: json["views_count"],
        sharesCount: json["shares_count"],
        length: json["length"] ?? "",
        language: json["language"],
        releaseDate: DateTime.parse(json["release_date"]),
        maturityRating: json["maturity_rating"],
        status: json["status"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        parentMediaId: json["parent_media_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        price: json["price"] ?? 0,
        likesCount: json["likes_count"] ?? 0,
        playsCount: json["plays_count"] ?? 0,
        type: json["type"],
        originalSource: json["original_source"] ?? "",
        imageUrl: json["image_url"] ?? "",
        lyrics: json["lyrics"],
        lyricsSplit: json["lyrics_split"],
        favoritesCount: json["favoritesCount"],
        isFavourite: json["isFavourite"],
        seasonCount: json["seasonCount"],
        episodeCount: json["episode_count"],
        category: List<dynamic>.from(json["category"].map((x) => x)),
        content: List<dynamic>.from(json["content"].map((x) => x)),
        artists: json["artists"] == null
            ? []
            : List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        upcomingEvents: json["upcoming-event"] == null
            ? []
            : List<EventModel>.from(
                json["upcoming-event"].map((x) => EventModel.fromJson(x))),
        pivot:
            json["pivot"] == null ? null : MediaPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "description": description.toJson(),
        "short_description": shortDescription.toJson(),
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
        "plays_count": playsCount,
        "type": type,
        "original_source": originalSource,
        "image_url": imageUrl,
        "lyrics": lyrics,
        "lyrics_split": lyricsSplit,
        "favoritesCount": favoritesCount,
        "isFavourite": isFavourite,
        "seasonCount": seasonCount,
        "episode_count": episodeCount,
        "category": List<dynamic>.from(category.map((x) => x)),
        "content": List<dynamic>.from(content.map((x) => x)),
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "upcoming-event":
            List<dynamic>.from(upcomingEvents.map((x) => x.toJson())),
        "pivot": pivot?.toJson(),
      };
}

class Description {
  Description({
    required this.en,
  });

  String en;

  factory Description.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Description(
        en: "",
      );
    } else {
      return Description(
        en: json["en"].toString().capitalize!,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class MediaPivot {
  MediaPivot({
    required this.userId,
    required this.mediaId,
  });

  int userId;
  int mediaId;

  factory MediaPivot.fromJson(Map<String, dynamic> json) => MediaPivot(
        userId: json["user_id"],
        mediaId: json["media_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
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
  SubcategoryMeta meta;
  int sortOrder;
  dynamic parentId;
  DateTime createdAt;
  DateTime updatedAt;
  SubcategoryPivot pivot;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        slug: json["slug"],
        title: Description.fromJson(json["title"]),
        meta: SubcategoryMeta.fromJson(json["meta"]),
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

class SubcategoryMeta {
  SubcategoryMeta({
    required this.color,
    required this.scope,
  });

  String color;
  String scope;

  factory SubcategoryMeta.fromJson(Map<String, dynamic> json) =>
      SubcategoryMeta(
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

class DataMeta {
  DataMeta({
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

  factory DataMeta.fromJson(Map<String, dynamic> json) => DataMeta(
        bio: json["bio"] ?? "",
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

class Story {
  Story({
    required this.id,
    required this.userId,
    required this.mediaId,
    required this.url,
    required this.acceptedDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int mediaId;
  String url;
  DateTime acceptedDate;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        userId: json["user_id"],
        mediaId: json["media_id"],
        url: json["url"],
        acceptedDate: DateTime.parse(json["accepted_date"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "media_id": mediaId,
        "url": url,
        "accepted_date": acceptedDate.toIso8601String(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UpcomingEvent {
  UpcomingEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.purchaseLink,
    required this.eventDate,
    required this.callNumber,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  int id;
  String title;
  dynamic description;
  String location;
  String purchaseLink;
  DateTime eventDate;
  String callNumber;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;
  UpcomingEventPivot pivot;

  factory UpcomingEvent.fromJson(Map<String, dynamic> json) => UpcomingEvent(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        purchaseLink: json["purchase_link"],
        eventDate: DateTime.parse(json["event_date"]),
        callNumber: json["call_number"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: UpcomingEventPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "location": location,
        "purchase_link": purchaseLink,
        "event_date":
            "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
        "call_number": callNumber,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class UpcomingEventPivot {
  UpcomingEventPivot({
    required this.userId,
    required this.upcomingeventId,
  });

  int userId;
  int upcomingeventId;

  factory UpcomingEventPivot.fromJson(Map<String, dynamic> json) =>
      UpcomingEventPivot(
        userId: json["user_id"],
        upcomingeventId: json["upcomingevent_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "upcomingevent_id": upcomingeventId,
      };
}
