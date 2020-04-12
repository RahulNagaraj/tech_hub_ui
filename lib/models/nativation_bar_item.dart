import 'package:flutter/material.dart';

import '../styles/colors.dart';

class NavigationBarItem {
  final int index;
  final String title;
  final IconData iconData;
  final Color color;

  NavigationBarItem(
      {@required this.index,
      @required this.title,
      @required this.iconData,
      @required this.color})
      : assert(index != null),
        assert(title != null),
        assert(iconData != null),
        assert(color != null);
}

final List<NavigationBarItem> navigationBarItems = [
  NavigationBarItem(
      index: 0, title: 'Home', iconData: Icons.home, color: tertiaryTextColor),
  NavigationBarItem(
      index: 1,
      title: 'Search',
      iconData: Icons.search,
      color: tertiaryTextColor),
  NavigationBarItem(
      index: 2,
      title: 'Favorites',
      iconData: Icons.favorite,
      color: tertiaryTextColor),
  NavigationBarItem(
      index: 3,
      title: 'Profile',
      iconData: Icons.person,
      color: tertiaryTextColor)
];
