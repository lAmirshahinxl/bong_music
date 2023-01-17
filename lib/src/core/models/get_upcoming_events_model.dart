import 'dart:convert';

GetUpcomingEventsModel getUpcomingEventsModelFromJson(String str) =>
    GetUpcomingEventsModel.fromJson(json.decode(str));

String getUpcomingEventsModelToJson(GetUpcomingEventsModel data) =>
    json.encode(data.toJson());

class GetUpcomingEventsModel {
  GetUpcomingEventsModel({
    required this.data,
    required this.code,
    required this.message,
  });

  List<EventModel> data;
  int code;
  dynamic message;

  factory GetUpcomingEventsModel.fromJson(Map<String, dynamic> json) =>
      GetUpcomingEventsModel(
        data: List<EventModel>.from(
            json["data"].map((x) => EventModel.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class EventModel {
  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.purchaseLink,
    required this.eventDate,
    required this.callNumber,
    required this.imageUrl,
    required this.isCanceled,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  int id;
  String title;
  String description;
  String location;
  String purchaseLink;
  DateTime eventDate;
  String callNumber;
  String imageUrl;
  String isCanceled;
  DateTime createdAt;
  DateTime updatedAt;
  String status;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        location: json["location"] ?? "",
        purchaseLink: json["purchase_link"],
        eventDate: DateTime.parse(json["event_date"]),
        callNumber: json["call_number"] ?? "",
        imageUrl: json["image_url"] ?? "",
        isCanceled: json["is_canceled"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "location": location,
        "purchase_link": purchaseLink,
        "event_date": eventDate.toIso8601String(),
        "call_number": callNumber,
        "image_url": imageUrl,
        "is_canceled": isCanceled,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
      };
}
