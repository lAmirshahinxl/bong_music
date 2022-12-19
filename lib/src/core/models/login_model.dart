import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.token,
    required this.user,
  });

  String token;
  User user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
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
