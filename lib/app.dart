import 'package:flutter/material.dart';

import './models/nativation_bar_item.dart';
import './pages/favorites_page.dart';
import './pages/home_page.dart';
import './pages/profile_page.dart';
import './pages/search_page.dart';
import './widgets/bottom_navigation_bar.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedBarIndex = 0;
  final List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onBottomBarItemTap(int index) {
    if (index != _selectedBarIndex) {
      setState(() {
        _selectedBarIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedBarIndex),
      bottomNavigationBar: BottomNavigation(
        selectedBarIndex: _selectedBarIndex,
        onBottomBarItemTap: _onBottomBarItemTap,
        navigationBarItems: navigationBarItems,
      ),
    );
  }
}
