import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unsplash_app/pages/collection_page.dart';
import 'package:unsplash_app/pages/search_page.dart';

import '../services/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = <Widget>[
    const SearchPage(),
    const CollectionPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        height: 70,
        elevation: 0,
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: ''),
          NavigationDestination(icon: Icon(Iconsax.category_2), label: ''),
        ],
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}
