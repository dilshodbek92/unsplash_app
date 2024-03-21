import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/collections_res.dart';
import '../services/http_service.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  bool isLoading = true;
  List<CollectionsRes> collections = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiCollections();
  }

  _apiCollections() async {
    var response =
    await Network.GET(Network.API_COLLECTIONS, Network.paramsCollections());
    setState(() {
      collections = Network.parseCollections(response!);
      isLoading = false;
    });
  }

  Future<void> _handleRefresh() async {
    _apiCollections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Collections'),
      ),
      body: Stack(
        children: [
          Center(
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView.builder(
                itemCount: collections.length,
                itemBuilder: (context, index) {
                  return _itemOfCollections(collections[index]);
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

  Widget _itemOfCollections(CollectionsRes collection) {
    return GestureDetector(
      // onTap: _callDetailsPage(),
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
        height: 250,
        width: double.infinity,
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: collection.coverPhoto.urls.full,
              // placeholder: (context, urls) => CircularProgressIndicator(),
              errorWidget: (context, urls, error) => Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.2),
                        ],
                      )
                  ),
                ),
              ),
            ),
            Container(
              height: double.infinity,
              margin: EdgeInsets.all(15),
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(collection.title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),
                  SizedBox(height: 5),
                  Text("${collection.totalPhotos.toString()} photos", style: TextStyle(color: Colors.white, fontSize: 15),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
