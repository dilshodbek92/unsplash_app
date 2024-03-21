import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unsplash_app/models/search_photos_res.dart';
import '../models/photos_res.dart';
import '../services/http_service.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = true;
  List<PhotosRes> photos = [];
  List<SearchPhoto> searchPhotos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPhotos();
    // _apiSearchPhotos();
  }

  _apiPhotos() async {
    var response = await Network.GET(Network.API_PHOTOS, Network.paramsPhotos());
    setState(() {
      photos = Network.parsePhotosList(response!);
      isLoading = false;
    });
  }

  _apiSearchPhotos() async {
    var response = await Network.GET(Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos());
    // LogService.d(response!);
    SearchPhotosRes searchPhotosRes = Network.parseSearchPhotos(response!);
    setState(() {
      searchPhotos = searchPhotosRes.searchPhotos;
      isLoading = false;
    });
  }

  Future<void> _handleRefresh() async {
    _apiPhotos();
  }

  _callDetailsPage(PhotosRes photos) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailsPage(photos: photos);
        },
      ),
    );
  }
  // WidgetsBinding.instance!.addPostFrameCallback(() {
  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DetailsPage(photos: photos)));
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Container(
          height: 46,
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              border:
                  Border.all(width: 1, color: Colors.grey.withOpacity(0.5))),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search photos, collections,users",
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintStyle: TextStyle(color: Colors.grey[700])),
          ),
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _handleRefresh,
            child: MasonryGridView.count(
              itemCount: photos.length,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return _itemOfPhotos(photos[index]);
              },
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _itemOfPhotos(PhotosRes photos) {
    return GestureDetector(
      onTap: _callDetailsPage(photos),
      child: Container(
        margin: const EdgeInsets.all(1),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: photos.urls.full,
          placeholder: (context, urls) => CircularProgressIndicator(),
          errorWidget: (context, urls, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
