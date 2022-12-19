import 'dart:convert';

ToggleFavoriteModel toggleFavoriteModelFromJson(String str) =>
    ToggleFavoriteModel.fromJson(json.decode(str));

String toggleFavoriteModelToJson(ToggleFavoriteModel data) =>
    json.encode(data.toJson());

class ToggleFavoriteModel {
  ToggleFavoriteModel({
    required this.code,
    required this.message,
  });

  int? code;
  String message;

  factory ToggleFavoriteModel.fromJson(Map<String, dynamic> json) =>
      ToggleFavoriteModel(
        code: json["code"] ?? 400,
        message: json["message"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "code": code ?? 400,
        "message": message.toString(),
      };
}
