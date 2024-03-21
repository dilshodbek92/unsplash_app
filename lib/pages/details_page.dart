import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unsplash_app/pages/home_page.dart';
import '../models/photos_res.dart';

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
        appBar: AppBar(
          title: Text("Cat"),
          actions: [
            Icon(Icons.save_alt_outlined),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/cat.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.only(top: 660),
                  child: Icon(
                    Icons.account_circle_outlined,color: Colors.white,
                    size: 30,
                  ),

                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  padding: EdgeInsets.only(top: 660),
                  child: Icon(
                    Icons.data_saver_on_outlined,color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),

          ],
        ),
      );

  }
}
