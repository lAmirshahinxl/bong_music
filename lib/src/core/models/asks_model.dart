// To parse this JSON data, do
//
//     final asksModel = asksModelFromJson(jsonString);

import 'dart:convert';

AsksModel asksModelFromJson(String str) => AsksModel.fromJson(json.decode(str));

String asksModelToJson(AsksModel data) => json.encode(data.toJson());

class AsksModel {
  AsksModel({
    required this.asks,
    required this.bids,
  });

  List<List<String>> asks;
  List<List<String>> bids;

  factory AsksModel.fromJson(Map<String, dynamic> json) => AsksModel(
    asks: List<List<String>>.from(json["asks"].map((x) => List<String>.from(x.map((x) => x)))),
    bids: List<List<String>>.from(json["bids"].map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "asks": List<dynamic>.from(asks.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "bids": List<dynamic>.from(bids.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}
