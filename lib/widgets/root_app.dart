import 'package:app_real_estate/pages/home.dart';
import 'package:flutter/material.dart';

import '../pages/profile.dart';
import '../pages/pub_page.dart';
import '../pages/search_page.dart';


class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int _selectedIndex = 0;

  static  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    PubPage(),
    SearchPage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.public),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
