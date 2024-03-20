import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_app/pages/collection_page.dart';
import 'package:unsplash_app/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; //New

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> _pages = <Widget>[

      SearchPage(),
      CollectionPage()
    ];
    return Scaffold(

      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.collections), label: ''),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );

  }
}
