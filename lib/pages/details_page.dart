import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:unsplash_app/services/log_service.dart';
import '../models/photos_res.dart';
import 'package:iconsax/iconsax.dart';

class DetailsPage extends StatefulWidget {
  // final PhotosRes photos;
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 1,
                image: AssetImage(
                  'assets/images/cat.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
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
                          backgroundColor: Colors.black.withOpacity(0.2),
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 700,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Iconsax.arrow_down,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Cats cannot taste sweet things",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "Cats can see in color",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "Cats sweat through their paws",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Iconsax.info_circle,
                        size: 30,
                        shadows: [Shadow(color: Colors.black, blurRadius: 7.0)],
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Text(
                      "Kitty Cat",
                      style: TextStyle(color: Colors.white, fontSize: 20, shadows: [Shadow(color: Colors.black, blurRadius: 3.0)],),
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
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
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
                        shadows: [Shadow(color: Colors.black, blurRadius: 7.0)],
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
                            shadows: [Shadow(color: Colors.black, blurRadius: 7.0)],
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
