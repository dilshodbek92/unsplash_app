import 'dart:convert';
import 'package:http/http.dart';
import '../models/collections_photos.dart';
import '../models/collections.dart';
import '../models/photos.dart';
import '../models/search_photos.dart';

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
      'order_by': 'latest',
      'client_id': CLIENT_ID
    });
    return params;
  }

  static Map<String, String> paramsSearchPhotos(String query) {
    Map<String, String> params = {};
    params.addAll({
      'query': query,
      'page': '1',
      'per_page': '20',
      'client_id': CLIENT_ID
    });
    return params;
  }

  static Map<String, String> paramsCollections() {
    Map<String, String> params = {};
    params.addAll({
      'page': '1',
      'per_page': '20',
      'client_id': CLIENT_ID
    });
    return params;
  }

  static Map<String, String> paramsCollectionsPhotos() {
    Map<String, String> params = {};
    params.addAll({
      'page': '1',
      'per_page': '20',
      'client_id': CLIENT_ID
    });
    return params;
  }

  /* Http Parsing */
  static List<Photo> parsePhotosList(String response) {
    dynamic json = jsonDecode(response);
    return List<Photo>.from(json.map((x) => Photo.fromJson(x)));
  }

  static SearchPhotosRes parseSearchPhotos(String response) {
    dynamic json = jsonDecode(response);
    return SearchPhotosRes.fromJson(json);
  }

  static List<Collections> parseCollections(String response) {
    dynamic json = jsonDecode(response);
    return List<Collections>.from(json.map((x) => Collections.fromJson(x)));
  }

  static List<CollectionsPhotos> parseCollectionsPhotos(String response) {
    dynamic json = jsonDecode(response);
    return List<CollectionsPhotos>.from(json.map((x) => CollectionsPhotos.fromJson(x)));
  }
}
