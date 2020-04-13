import 'package:flutter/material.dart';

import '../models/nativation_bar_item.dart';
import '../styles/colors.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/event_card.dart';
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
      final List<LinearGradient> gradient = [event1, event2, event3];
      for (int i = 0; i < 3; i++) {
        _eventCards.add(
          EventCard(
            deviceWidth: _deviceWidth,
            deviceHeight: _deviceHeight,
            title: 'Brightlight Music Festival',
            subTitle: 'Friday Aug 24, 9PM',
            gradient: gradient[i],
          ),
        );
        // So that we don't add extra width of 16 px to the last card
        // TODO: change the value to last index in the list
        if (i != 2) {
          _eventCards.add(
            SizedBox(
              width: 16.0,
            ),
          );
        }
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
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
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
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: _buildEventCards(),
                  ),
                ),
              ),
              Container(
                width: 400,
                height: 400,
                color: Colors.blue,
              ),
              Container(
                width: 400,
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
