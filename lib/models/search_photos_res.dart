// To parse this JSON data, do
//
//     final searchPhotosRes = searchPhotosResFromJson(jsonString);

import 'dart:convert';

SearchPhotosRes searchPhotosResFromJson(String str) =>
    SearchPhotosRes.fromJson(json.decode(str));

String searchPhotosResToJson(SearchPhotosRes data) =>
    json.encode(data.toJson());

class SearchPhotosRes {
  int total;
  int totalPages;
  List<SearchPhoto> results;

  SearchPhotosRes({
    required this.total,
    required this.totalPages,
    required this.results,
  });

  factory SearchPhotosRes.fromJson(Map<String, dynamic> json) =>
      SearchPhotosRes(
        total: json["total"],
        totalPages: json["total_pages"],
        results: List<SearchPhoto>.from(
            json["results"].map((x) => SearchPhoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "total_pages": totalPages,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class SearchPhoto {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? promotedAt;
  int width;
  int height;
  String color;
  String? description;
  String altDescription;
  Urls urls;

  SearchPhoto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.promotedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.description,
    required this.altDescription,
    required this.urls,
  });

  factory SearchPhoto.fromJson(Map<String, dynamic> json) => SearchPhoto(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        promotedAt: json["promoted_at"] == null
            ? null
            : DateTime.parse(json["promoted_at"]),
        width: json["width"],
        height: json["height"],
        color: json["color"],
        description: json["description"],
        altDescription: json["alt_description"],
        urls: Urls.fromJson(json["urls"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "promoted_at": promotedAt?.toIso8601String(),
        "width": width,
        "height": height,
        "color": color,
        "description": description,
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
