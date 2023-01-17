class CatgeoryChildsModel {
  List<Data>? data;
  int? code;
  String? message;

  CatgeoryChildsModel({this.data, this.code, this.message});

  CatgeoryChildsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? categoryId;
  String? title;
  String? description;
  String? imageUrl;
  String? creator;
  String? visibility;
  int? followers;
  int? isAlbum;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;
  List<Media>? media;
  bool? isLiked;

  Data(
      {this.id,
      this.userId,
      this.categoryId,
      this.title,
      this.description,
      this.imageUrl,
      this.creator,
      this.visibility,
      this.followers,
      this.isAlbum,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.media,
      this.isLiked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['image_url'];
    creator = json['creator'];
    visibility = json['visibility'];
    followers = json['followers'];
    isAlbum = json['isAlbum'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['description'] = description;
    data['image_url'] = imageUrl;
    data['creator'] = creator;
    data['visibility'] = visibility;
    data['followers'] = followers;
    data['isAlbum'] = isAlbum;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    data['isLiked'] = isLiked;
    return data;
  }
}

class Media {
  int? id;
  Title? title;
  Title? description;
  Title? shortDescription;
  int? viewsCount;
  int? sharesCount;
  String? releaseDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? likesCount;
  int? playsCount;
  String? type;
  String? originalSource;
  String? imageUrl;
  String? lyrics;
  String? lyricsSplit;
  int? favoritesCount;
  bool? isFavourite;
  int? seasonCount;
  int? episodeCount;
  Pivot? pivot;
  List<Category>? category;

  Media(
      {this.id,
      this.title,
      this.description,
      this.shortDescription,
      this.viewsCount,
      this.sharesCount,
      this.releaseDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.likesCount,
      this.playsCount,
      this.type,
      this.originalSource,
      this.imageUrl,
      this.lyrics,
      this.lyricsSplit,
      this.favoritesCount,
      this.isFavourite,
      this.seasonCount,
      this.episodeCount,
      this.pivot,
      this.category});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    description = json['description'] != null
        ? Title.fromJson(json['description'])
        : null;
    shortDescription = json['short_description'] != null
        ? Title.fromJson(json['short_description'])
        : null;
    viewsCount = json['views_count'];
    sharesCount = json['shares_count'];
    releaseDate = json['release_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likesCount = json['likes_count'];
    playsCount = json['plays_count'];
    type = json['type'];
    originalSource = json['original_source'];
    imageUrl = json['image_url'];
    lyrics = json['lyrics'];
    lyricsSplit = json['lyrics_split'];
    favoritesCount = json['favoritesCount'];
    isFavourite = json['isFavourite'];
    seasonCount = json['seasonCount'];
    episodeCount = json['episode_count'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    if (shortDescription != null) {
      data['short_description'] = shortDescription!.toJson();
    }

    data['views_count'] = viewsCount;
    data['shares_count'] = sharesCount;
    data['release_date'] = releaseDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['likes_count'] = likesCount;
    data['plays_count'] = playsCount;
    data['type'] = type;
    data['original_source'] = originalSource;
    data['image_url'] = imageUrl;
    data['lyrics'] = lyrics;
    data['lyrics_split'] = lyricsSplit;
    data['favoritesCount'] = favoritesCount;
    data['isFavourite'] = isFavourite;
    data['seasonCount'] = seasonCount;
    data['episode_count'] = episodeCount;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Title {
  String? en;

  Title({this.en});

  Title.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    return data;
  }
}

class Pivot {
  int? playlistId;
  int? mediaId;

  Pivot({this.playlistId, this.mediaId});

  Pivot.fromJson(Map<String, dynamic> json) {
    playlistId = json['playlist_id'];
    mediaId = json['media_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_id'] = mediaId;
    return data;
  }
}

class Category {
  int? id;
  String? slug;
  Title? title;
  Meta? meta;
  int? sortOrder;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Category(
      {this.id,
      this.slug,
      this.title,
      this.meta,
      this.sortOrder,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    sortOrder = json['sort_order'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['sort_order'] = sortOrder;
    data['parent_id'] = parentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Meta {
  String? color;
  String? scope;

  Meta({this.color, this.scope});

  Meta.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['scope'] = scope;
    return data;
  }
}
