import 'package:flutter/material.dart';

import '../models/nativation_bar_item.dart';
import '../styles/colors.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedBarIndex;
  final Function onBottomBarItemTap;
  final List<NavigationBarItem> navigationBarItems;

  const BottomNavigation(
      {Key key,
      @required this.selectedBarIndex,
      @required this.onBottomBarItemTap,
      @required this.navigationBarItems})
      : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 500);

  List<Widget> _buildBarItems(BuildContext context) {
    List<Widget> _barItems = new List();
    for (var barItem in widget.navigationBarItems) {
      bool _isSelected = barItem.index == widget.selectedBarIndex;
      _barItems.add(InkWell(
        onTap: () {
          widget.onBottomBarItemTap(barItem.index);
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          duration: duration,
          decoration: BoxDecoration(
              color: _isSelected ? tertiaryTintColor : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            children: <Widget>[
              Icon(
                barItem.iconData,
                color: _isSelected ? tertiaryTextColor : greyTextColor,
                size: 24.0,
              ),
              SizedBox(
                width: 10,
              ),
              AnimatedSize(
                  duration: duration,
                  curve: Curves.easeInOutBack,
                  vsync: this,
                  child: Text(
                    _isSelected ? barItem.title : '',
                    style: Theme.of(context).textTheme.caption,
                  ))
            ],
          ),
        ),
      ));
    }
    return _barItems;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildBarItems(context),
        ),
      ),
    );
  }
}
