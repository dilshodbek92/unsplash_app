import 'package:flutter/material.dart';
import 'package:unsplash_app/pages/collection_photos_page.dart';
import 'package:unsplash_app/pages/details_page.dart';
import 'package:unsplash_app/pages/home_page.dart';
import 'package:unsplash_app/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}