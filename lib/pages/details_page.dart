import 'package:flutter/material.dart';
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
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/cat.png'),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
