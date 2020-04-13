import 'package:flutter/material.dart';
import 'package:techhubui/widgets/event_card.dart';

import '../models/nativation_bar_item.dart';
import '../styles/colors.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/heading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBarIndex = 0;

  void _onBottomBarItemTap(index) {
    setState(() {
      _selectedBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;

    List<Widget> _buildEventCards() {
      List<Widget> _eventCards = new List();
      for (int i = 0; i < 3; i++) {
        _eventCards.add(
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: EventCard(
              deviceWidth: _deviceWidth,
              deviceHeight: _deviceHeight,
              title: 'Brightlight Music Festival',
              subTitle: 'Friday Aug 24, 9PM',
            ),
          ),
        );
      }
      return _eventCards;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: Heading(heading: 'For You'),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.filter_list,
                          color: tertiaryTextColor,
                          size: 28.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 20.0,
                  bottom: 20.0,
                ),
                child: Row(
                  children: _buildEventCards(),
                ),
              ),
              Container(
                height: 400,
                color: Colors.blue,
              ),
              Container(
                height: 400,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        navigationBarItems: navigationBarItems,
        selectedBarIndex: _selectedBarIndex,
        onBottomBarItemTap: _onBottomBarItemTap,
      ),
    );
  }
}
