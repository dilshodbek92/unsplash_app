import 'dart:convert';
import 'package:http/http.dart';
import '../models/collections_photos_res.dart';
import '../models/collections_res.dart';
import '../models/photos_res.dart';
import '../models/search_photos_res.dart';

class Network {
  static String BASE = "api.unsplash.com";
  static String CLIENT_ID = "_HZfRbawOhlrLnIlET3ZMHOqpc1wweEY6lcu8ThXld4";

  /* Http Apis*/
  static String API_PHOTOS = "/photos";
  static String API_SEARCH_PHOTOS = "/search/photos";
  static String API_COLLECTIONS = "/collections";
  static String API_COLLECTIONS_PHOTOS = "/collections/:id/photos";

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  /* Http Requests */
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Params */
  static Map<String, String> paramsPhotos() {
    Map<String, String> params = {};
    params.addAll({
      'page': '1',
      'per_page': '20',
      'client_id': CLIENT_ID
    });
    return params;
  }

  static Map<String, String> paramsSearchPhotos(String query) {
    Map<String, String> params = {};
    params.addAll({
      'query': query,
      'client_id': CLIENT_ID
    });
    return params;
  }

  static Map<String, String> paramsCollections() {
    Map<String, String> params = {};
    params.addAll({
      'client_id': CLIENT_ID
    });
    return params;
  }

  static Map<String, String> paramsCollectionsPhotos() {
    Map<String, String> params = {};
    params.addAll({
      'id': '1',
      'client_id': CLIENT_ID
    });
    return params;
  }

  /* Http Parsing */
  static List<PhotosRes> parsePhotosList(String response) {
    dynamic json = jsonDecode(response);
    return List<PhotosRes>.from(json.map((x) => PhotosRes.fromJson(x)));
  }

  static SearchPhotosRes parseSearchPhotos(String response) {
    dynamic json = jsonDecode(response);
    return SearchPhotosRes.fromJson(json);
  }

  static List<CollectionsRes> parseCollections(String response) {
    dynamic json = jsonDecode(response);
    return List<CollectionsRes>.from(json.map((x) => CollectionsRes.fromJson(x)));
  }

  static List<CollectionsPhotosRes> parseCollectionsPhotos(String response) {
    dynamic json = jsonDecode(response);
    return List<CollectionsPhotosRes>.from(json.map((x) => CollectionsPhotosRes.fromJson(x)));
  }
}
