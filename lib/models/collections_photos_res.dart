// To parse this JSON data, do
//
//     final collectionsPhotosRes = collectionsPhotosResFromJson(jsonString);

import 'dart:convert';

List<CollectionsPhotosRes> collectionsPhotosResFromJson(String str) =>
    List<CollectionsPhotosRes>.from(
        json.decode(str).map((x) => CollectionsPhotosRes.fromJson(x)));

String collectionsPhotosResToJson(List<CollectionsPhotosRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CollectionsPhotosRes {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime promotedAt;
  int width;
  int height;
  String color;
  String altDescription;
  Urls urls;

  CollectionsPhotosRes({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.promotedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.altDescription,
    required this.urls,
  });

  factory CollectionsPhotosRes.fromJson(Map<String, dynamic> json) =>
      CollectionsPhotosRes(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        promotedAt: DateTime.parse(json["promoted_at"]),
        width: json["width"],
        height: json["height"],
        color: json["color"],
        altDescription: json["alt_description"],
        urls: Urls.fromJson(json["urls"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "promoted_at": promotedAt.toIso8601String(),
        "width": width,
        "height": height,
        "color": color,
        "alt_description": altDescription,
        "urls": urls.toJson(),
      };
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String smallS3;

  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
        smallS3: json["small_s3"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
        "small_s3": smallS3,
      };
}
