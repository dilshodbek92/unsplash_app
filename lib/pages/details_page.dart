import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            padding: const EdgeInsets.all(20),
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
                      icon: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Icon(
                          Iconsax.arrow_left_3,
                          size: 30,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 8.0)
                          ],
                        ),
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
                      icon: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Icon(
                          Iconsax.info_circle,
                          size: 30,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 8.0)
                          ],
                        ),
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
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                // color: Colors.orange,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Share this photo via',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
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
                                                const Text('Facebook')
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                IconButton(
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.instagram,
                                                    color: Colors.purple,
                                                    size: 40,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                const Text('Instagram')
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                IconButton(
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.telegram,
                                                    color: Colors.blue,
                                                    size: 40,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                const Text('Telegram')
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                IconButton(
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.twitter,
                                                    color: Colors.blue,
                                                    size: 40,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                const Text('Twitter')
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      height: 40,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: Colors.grey[300],
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Icon(
                          Iconsax.export_3,
                          // size: 30,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 8.0)
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //# save image button
                        IconButton(
                          icon: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(25)),
                            child: const Icon(
                              Iconsax.gallery_import,
                              size: 25,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 8.0)
                              ],
                            ),
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

  static void _showToast() {
    Fluttertoast.showToast(
      msg: "Image saved",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  _saveNetworkImage() async {
    var response = await Dio().get(detailsPhoto.urls.full,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 80,
      name: "unsplash_app_${detailsPhoto.id}",
    );
    print(result);
    _showToast();
  }
}
