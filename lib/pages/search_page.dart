import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unsplash_app/models/search_photos.dart';
import '../models/details_photo.dart';
import '../models/photos.dart';
import '../services/http_service.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = true;
  DetailsPhoto? detailsPhoto;
  String? query;
  List<Photo> photos = [];
  List<SearchPhoto> searchPhotos = [];

  final TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPhotos();
  }

  _apiPhotos() async {
    var response = await Network.GET(Network.API_PHOTOS, Network.paramsPhotos());
    // LogService.d(response!);
    setState(() {
      photos = Network.parsePhotosList(response!);
      isLoading = false;
    });
  }

  _apiSearchPhotos(String? query) async {
    var response = await Network.GET(
        Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos(query!));
    // LogService.d(response!);
    // LogService.d(query);
    SearchPhotosRes searchPhotosRes = Network.parseSearchPhotos(response!);
    setState(() {
      searchPhotos = searchPhotosRes.searchPhotos;
      isLoading = false;
    });
    query = null;
  }

  void _searchPhotos() {
    query = _queryController.text;
    _apiSearchPhotos(query!);
  }

  _callDetailsPage(DetailsPhoto photo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailsPage(detailsPhoto: photo);
        },
      ),
    );
  }

  DetailsPhoto getPhoto(Photo photo){
    return DetailsPhoto(
      id: photo.id,
      createdAt: photo.createdAt,
      width: photo.width,
      height: photo.height,
      description: photo.description,
      urls: photo.urls,
      user: photo.user,
    );
  }
  DetailsPhoto getSearchPhoto(SearchPhoto searchPhoto){
    return DetailsPhoto(
      id: searchPhoto.id,
      createdAt: searchPhoto.createdAt,
      width: searchPhoto.width,
      height: searchPhoto.height,
      description: searchPhoto.description,
      urls: searchPhoto.urls,
      user: searchPhoto.user,
    );
  }

  Future<void> _handleRefresh() async {
    _apiPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // search bar
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              width: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          child: TextField(
            onSubmitted: (value) {
              _searchPhotos();
            },
            textAlignVertical: TextAlignVertical.top,
            controller: _queryController,
            decoration: InputDecoration(
              hintText: "Search photos, collections, users",
              hintStyle: const TextStyle(fontWeight: FontWeight.normal),
              border: InputBorder.none,
              prefixIcon: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: const Icon(Iconsax.search_normal),
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

  Widget _itemOfPhotos(Photo photo) {
    return GestureDetector(
      onTap: () {
        _callDetailsPage(getPhoto(photo));
      },
      child: AspectRatio(
        aspectRatio: photo.width.toDouble() / photo.height.toDouble(),
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 5),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: photo.urls.full,
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
      aspectRatio: searchPhotos.width.toDouble() / searchPhotos.height.toDouble(),
      child: GestureDetector(
        onTap: (){
          _callDetailsPage(getSearchPhoto(searchPhotos));
        },
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
