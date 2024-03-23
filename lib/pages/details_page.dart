import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:unsplash_app/services/log_service.dart';
import '../models/collections_photos.dart';
import '../models/details_photo.dart';
import '../models/photos.dart';
import 'package:iconsax/iconsax.dart';

class DetailsPage extends StatefulWidget {
  DetailsPhoto? detailsPhoto;

  DetailsPage({super.key, this.detailsPhoto});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late DetailsPhoto detailsPhoto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailsPhoto = widget.detailsPhoto!;
  }

  String getDescription() {
    if (detailsPhoto.description == null) {
      return '-';
    }
    return detailsPhoto.description!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: detailsPhoto.urls.full,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //# back button
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Iconsax.arrow_left_3,
                        size: 30,
                        shadows: [Shadow(color: Colors.black, blurRadius: 8.0)],
                      ),
                      color: Colors.white,
                    ),

                    //#bottom sheet
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          scrollControlDisabledMaxHeightRatio: double.infinity,
                          backgroundColor: Colors.black.withOpacity(0.8),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.all(30),
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: detailsPhoto
                                              .user.profileImage.medium,
                                          placeholder: (context, urls) =>
                                              Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, urls, error) =>
                                              const Icon(Icons.error),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        detailsPhoto.user.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                      'Description',
                                      style: TextStyle(color: Colors.white30),
                                    ),
                                  ),
                                  Text(
                                    getDescription(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                      'Published',
                                      style: TextStyle(color: Colors.white30),
                                    ),
                                  ),
                                  Text(
                                    detailsPhoto.createdAt
                                        .toIso8601String()
                                        .substring(0, 10),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                      'Dimensions',
                                      style: TextStyle(color: Colors.white30),
                                    ),
                                  ),
                                  Text(
                                    '${detailsPhoto.width} / ${detailsPhoto.height}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Iconsax.info_circle,
                        size: 30,
                        shadows: [Shadow(color: Colors.black, blurRadius: 8.0)],
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //# share button
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          scrollControlDisabledMaxHeightRatio: double.infinity,
                          backgroundColor: Colors.black.withOpacity(0.7),
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 140,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Choose to send',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          icon: const FaIcon(
                                            FontAwesomeIcons.facebook,
                                            color: Colors.blue,
                                            size: 40,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.instagram,
                                            size: 40,
                                            color: Colors.purple,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.telegram,
                                            size: 40,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.snapchat,
                                            size: 40,
                                            color: Colors.yellowAccent,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.twitter,
                                            size: 40,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Iconsax.send_1,
                        size: 30,
                        shadows: [Shadow(color: Colors.black, blurRadius: 8.0)],
                      ),
                      color: Colors.white,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //# save image button
                        IconButton(
                          icon: const Icon(
                            Iconsax.arrow_down_2,
                            size: 30,
                            shadows: [Shadow(color: Colors.black, blurRadius: 8.0)],
                          ),
                          color: Colors.white,
                          onPressed: () {
                            _saveNetworkImage();
                            LogService.i('hi');
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_saveNetworkImage() async {
  var response = await Dio().get(
      "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
      options: Options(responseType: ResponseType.bytes));
  final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: "hello");
  print(result);
}
