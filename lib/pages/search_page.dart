import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  String? query;
  bool isLoading = true;
  List<PhotosRes> photos = [];
  List<SearchPhoto> searchPhotos = [];

  final TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _apiSearchPhotos();
    _apiPhotos();

    // SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
    //   _callDetailsPage();
    // });
  }

  _apiPhotos() async {
    var response =
        await Network.GET(Network.API_PHOTOS, Network.paramsPhotos());
    setState(() {
      photos = Network.parsePhotosList(response!);
      isLoading = false;
    });
  }

  _apiSearchPhotos() async {
    var response = await Network.GET(
        Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos());
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

  _callDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailsPage();
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
      // backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Container(
          height: 46,
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              border:
                  Border.all(width: 1, color: Colors.grey.withOpacity(0.5))),
          child: TextField(
            controller: _queryController,
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
            child: Container(
              padding: EdgeInsets.only(right: 5),
              child: MasonryGridView.count(
                itemCount: photos.length,
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  return _itemOfPhotos(photos[index]);
                },
              ),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _itemOfPhotos(PhotosRes photos)  {
    return AspectRatio(
      aspectRatio: photos.width.toDouble() / photos.height.toDouble(),
      child: GestureDetector(
         onTap: _callDetailsPage(),
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
            errorWidget: (context, urls, error) => Icon(Icons.error),
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
