import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unsplash_app/models/search_photos_res.dart';
import '../models/photos_res.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? query;
  List<PhotosRes> photos = [];
  List<SearchPhoto> searchPhotos = [];

  final TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPhotos();
  }

  void _searchPhotos() {
    query = _queryController.text;
    _apiSearchPhotos(query!);
  }

  _apiPhotos() async {
    var response =
        await Network.GET(Network.API_PHOTOS, Network.paramsPhotos());
    LogService.d(response!);
    setState(() {
      photos = Network.parsePhotosList(response);
    });
  }

  _apiSearchPhotos(String? query) async {
    var response = await Network.GET(
        Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos(query!));
    LogService.d(response!);
    LogService.d(query);

    SearchPhotosRes searchPhotosRes = Network.parseSearchPhotos(response);
    setState(() {
      searchPhotos = searchPhotosRes.results;
    });
    query = null;
    // LogService.d(query!);
  }

  Future<void> _handleRefresh() async {
    _apiPhotos();
  }

  _callDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const DetailsPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
          ),
          child: TextField(
            onSubmitted: (value) {
              _searchPhotos();
            },
            textAlignVertical: TextAlignVertical.top,
            controller: _queryController,
            decoration: InputDecoration(
              hintText: "Search photos, collections, users",
              hintStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
              border: InputBorder.none,
              prefixIcon: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: const Icon(
                  Iconsax.search_normal,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _handleRefresh,
            child: Container(
              padding: const EdgeInsets.only(right: 5),
              child: query == null
                  ? MasonryGridView.count(
                      itemCount: photos.length,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        return _itemOfPhotos(photos[index]);
                      },
                    )
                  : MasonryGridView.count(
                      itemCount: searchPhotos.length,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        return _itemOfSearchPhotos(searchPhotos[index]);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemOfPhotos(PhotosRes photos) {
    return GestureDetector(
      onTap: () {
        _callDetailsPage();
      },
      child: AspectRatio(
        aspectRatio: photos.width.toDouble() / photos.height.toDouble(),
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 5),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: photos.urls.full,
            placeholder: (context, urls) => Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            errorWidget: (context, urls, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemOfSearchPhotos(SearchPhoto searchPhotos) {
    return AspectRatio(
      aspectRatio:
          searchPhotos.width.toDouble() / searchPhotos.height.toDouble(),
      child: GestureDetector(
        // onTap: _callDetailsPage(),
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 5),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: searchPhotos.urls.full,
            placeholder: (context, urls) => Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            errorWidget: (context, urls, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
