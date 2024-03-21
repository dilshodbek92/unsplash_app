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
  String slug;
  AlternativeSlugs alternativeSlugs;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  String description;
  String altDescription;
  List<Breadcrumb> breadcrumbs;
  Urls urls;
  CollectionsPhotosReLinks links;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  TopicSubmissions topicSubmissions;
  AssetType assetType;
  User user;

  CollectionsPhotosRes({
    required this.id,
    required this.slug,
    required this.alternativeSlugs,
    required this.createdAt,
    required this.updatedAt,
    required this.promotedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.description,
    required this.altDescription,
    required this.breadcrumbs,
    required this.urls,
    required this.links,
    required this.likes,
    required this.likedByUser,
    required this.currentUserCollections,
    required this.sponsorship,
    required this.topicSubmissions,
    required this.assetType,
    required this.user,
  });

  factory CollectionsPhotosRes.fromJson(Map<String, dynamic> json) =>
      CollectionsPhotosRes(
        id: json["id"],
        slug: json["slug"],
        alternativeSlugs: AlternativeSlugs.fromJson(json["alternative_slugs"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        promotedAt: DateTime.parse(json["promoted_at"]),
        width: json["width"],
        height: json["height"],
        color: json["color"],
        blurHash: json["blur_hash"],
        description: json["description"],
        altDescription: json["alt_description"],
        breadcrumbs: List<Breadcrumb>.from(
            json["breadcrumbs"].map((x) => Breadcrumb.fromJson(x))),
        urls: Urls.fromJson(json["urls"]),
        links: CollectionsPhotosReLinks.fromJson(json["links"]),
        likes: json["likes"],
        likedByUser: json["liked_by_user"],
        currentUserCollections:
            List<dynamic>.from(json["current_user_collections"].map((x) => x)),
        sponsorship: json["sponsorship"],
        topicSubmissions: TopicSubmissions.fromJson(json["topic_submissions"]),
        assetType: assetTypeValues.map[json["asset_type"]]!,
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "alternative_slugs": alternativeSlugs.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "promoted_at": promotedAt.toIso8601String(),
        "width": width,
        "height": height,
        "color": color,
        "blur_hash": blurHash,
        "description": description,
        "alt_description": altDescription,
        "breadcrumbs": List<dynamic>.from(breadcrumbs.map((x) => x.toJson())),
        "urls": urls.toJson(),
        "links": links.toJson(),
        "likes": likes,
        "liked_by_user": likedByUser,
        "current_user_collections":
            List<dynamic>.from(currentUserCollections.map((x) => x)),
        "sponsorship": sponsorship,
        "topic_submissions": topicSubmissions.toJson(),
        "asset_type": assetTypeValues.reverse[assetType],
        "user": user.toJson(),
      };
}

class AlternativeSlugs {
  String en;
  String es;
  String ja;
  String fr;
  String it;
  String ko;
  String de;
  String pt;

  AlternativeSlugs({
    required this.en,
    required this.es,
    required this.ja,
    required this.fr,
    required this.it,
    required this.ko,
    required this.de,
    required this.pt,
  });

  factory AlternativeSlugs.fromJson(Map<String, dynamic> json) =>
      AlternativeSlugs(
        en: json["en"],
        es: json["es"],
        ja: json["ja"],
        fr: json["fr"],
        it: json["it"],
        ko: json["ko"],
        de: json["de"],
        pt: json["pt"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "es": es,
        "ja": ja,
        "fr": fr,
        "it": it,
        "ko": ko,
        "de": de,
        "pt": pt,
      };
}

enum AssetType { PHOTO }

final assetTypeValues = EnumValues({"photo": AssetType.PHOTO});

class Breadcrumb {
  String slug;
  String title;
  int index;
  String type;

  Breadcrumb({
    required this.slug,
    required this.title,
    required this.index,
    required this.type,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
        slug: json["slug"],
        title: json["title"],
        index: json["index"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "title": title,
        "index": index,
        "type": type,
      };
}

class CollectionsPhotosReLinks {
  String self;
  String html;
  String download;
  String downloadLocation;

  CollectionsPhotosReLinks({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });

  factory CollectionsPhotosReLinks.fromJson(Map<String, dynamic> json) =>
      CollectionsPhotosReLinks(
        self: json["self"],
        html: json["html"],
        download: json["download"],
        downloadLocation: json["download_location"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
      };
}

class TopicSubmissions {
  BusinessWork? businessWork;
  BusinessWork? workFromHome;

  TopicSubmissions({
    this.businessWork,
    this.workFromHome,
  });

  factory TopicSubmissions.fromJson(Map<String, dynamic> json) =>
      TopicSubmissions(
        businessWork: json["business-work"] == null
            ? null
            : BusinessWork.fromJson(json["business-work"]),
        workFromHome: json["work-from-home"] == null
            ? null
            : BusinessWork.fromJson(json["work-from-home"]),
      );

  Map<String, dynamic> toJson() => {
        "business-work": businessWork?.toJson(),
        "work-from-home": workFromHome?.toJson(),
      };
}

class BusinessWork {
  String status;
  DateTime approvedOn;

  BusinessWork({
    required this.status,
    required this.approvedOn,
  });

  factory BusinessWork.fromJson(Map<String, dynamic> json) => BusinessWork(
        status: json["status"],
        approvedOn: DateTime.parse(json["approved_on"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "approved_on": approvedOn.toIso8601String(),
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

class User {
  Id id;
  DateTime updatedAt;
  Username username;
  Name name;
  FirstName firstName;
  LastName lastName;
  dynamic twitterUsername;
  String portfolioUrl;
  dynamic bio;
  Location location;
  UserLinks links;
  ProfileImage profileImage;
  InstagramUsername instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  int totalPromotedPhotos;
  bool acceptedTos;
  bool forHire;
  Social social;

  User({
    required this.id,
    required this.updatedAt,
    required this.username,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.twitterUsername,
    required this.portfolioUrl,
    required this.bio,
    required this.location,
    required this.links,
    required this.profileImage,
    required this.instagramUsername,
    required this.totalCollections,
    required this.totalLikes,
    required this.totalPhotos,
    required this.totalPromotedPhotos,
    required this.acceptedTos,
    required this.forHire,
    required this.social,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: idValues.map[json["id"]]!,
        updatedAt: DateTime.parse(json["updated_at"]),
        username: usernameValues.map[json["username"]]!,
        name: nameValues.map[json["name"]]!,
        firstName: firstNameValues.map[json["first_name"]]!,
        lastName: lastNameValues.map[json["last_name"]]!,
        twitterUsername: json["twitter_username"],
        portfolioUrl: json["portfolio_url"],
        bio: json["bio"],
        location: locationValues.map[json["location"]]!,
        links: UserLinks.fromJson(json["links"]),
        profileImage: ProfileImage.fromJson(json["profile_image"]),
        instagramUsername:
            instagramUsernameValues.map[json["instagram_username"]]!,
        totalCollections: json["total_collections"],
        totalLikes: json["total_likes"],
        totalPhotos: json["total_photos"],
        totalPromotedPhotos: json["total_promoted_photos"],
        acceptedTos: json["accepted_tos"],
        forHire: json["for_hire"],
        social: Social.fromJson(json["social"]),
      );

  Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "updated_at": updatedAt.toIso8601String(),
        "username": usernameValues.reverse[username],
        "name": nameValues.reverse[name],
        "first_name": firstNameValues.reverse[firstName],
        "last_name": lastNameValues.reverse[lastName],
        "twitter_username": twitterUsername,
        "portfolio_url": portfolioUrl,
        "bio": bio,
        "location": locationValues.reverse[location],
        "links": links.toJson(),
        "profile_image": profileImage.toJson(),
        "instagram_username":
            instagramUsernameValues.reverse[instagramUsername],
        "total_collections": totalCollections,
        "total_likes": totalLikes,
        "total_photos": totalPhotos,
        "total_promoted_photos": totalPromotedPhotos,
        "accepted_tos": acceptedTos,
        "for_hire": forHire,
        "social": social.toJson(),
      };
}

enum FirstName { ALEJANDRO }

final firstNameValues = EnumValues({"Alejandro": FirstName.ALEJANDRO});

enum Id { P_XHWZZ1_JT_QU }

final idValues = EnumValues({"pXhwzz1JtQU": Id.P_XHWZZ1_JT_QU});

enum InstagramUsername { ALEJANDROESCAMILLA_PHOTOGRAPHY }

final instagramUsernameValues = EnumValues({
  "alejandroescamilla_photography":
      InstagramUsername.ALEJANDROESCAMILLA_PHOTOGRAPHY
});

enum LastName { ESCAMILLA }

final lastNameValues = EnumValues({"Escamilla": LastName.ESCAMILLA});

class UserLinks {
  String self;
  String html;
  String photos;
  String likes;
  String portfolio;
  String following;
  String followers;

  UserLinks({
    required this.self,
    required this.html,
    required this.photos,
    required this.likes,
    required this.portfolio,
    required this.following,
    required this.followers,
  });

  factory UserLinks.fromJson(Map<String, dynamic> json) => UserLinks(
        self: json["self"],
        html: json["html"],
        photos: json["photos"],
        likes: json["likes"],
        portfolio: json["portfolio"],
        following: json["following"],
        followers: json["followers"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "photos": photos,
        "likes": likes,
        "portfolio": portfolio,
        "following": following,
        "followers": followers,
      };
}

enum Location { MONTREAL }

final locationValues = EnumValues({"montreal": Location.MONTREAL});

enum Name { ALEJANDRO_ESCAMILLA }

final nameValues =
    EnumValues({"Alejandro Escamilla": Name.ALEJANDRO_ESCAMILLA});

class ProfileImage {
  String small;
  String medium;
  String large;

  ProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "medium": medium,
        "large": large,
      };
}

class Social {
  InstagramUsername instagramUsername;
  String portfolioUrl;
  dynamic twitterUsername;
  dynamic paypalEmail;

  Social({
    required this.instagramUsername,
    required this.portfolioUrl,
    required this.twitterUsername,
    required this.paypalEmail,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        instagramUsername:
            instagramUsernameValues.map[json["instagram_username"]]!,
        portfolioUrl: json["portfolio_url"],
        twitterUsername: json["twitter_username"],
        paypalEmail: json["paypal_email"],
      );

  Map<String, dynamic> toJson() => {
        "instagram_username":
            instagramUsernameValues.reverse[instagramUsername],
        "portfolio_url": portfolioUrl,
        "twitter_username": twitterUsername,
        "paypal_email": paypalEmail,
      };
}

enum Username { ALEJANDROESCAMILLA }

final usernameValues =
    EnumValues({"alejandroescamilla": Username.ALEJANDROESCAMILLA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
