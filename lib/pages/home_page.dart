import 'package:flutter/material.dart';

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
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: _deviceWidth * 0.85,
                        height: _deviceHeight * 0.40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [secondaryTextColor, tertiaryTextColor],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                          color: darkBlueColor,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 4.0),
                                    child: Text(
                                      'Friday Aug 24, 9PM',
                                      style:
                                          Theme.of(context).textTheme.subtitle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 8.0),
                                    child: Text(
                                      'Brightlight Music Festival',
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ClipOval(
                                  child: Material(
                                    color: Color(0xFFFEEDF3)
                                        .withOpacity(0.25), // button color
                                    child: InkWell(
                                      splashColor: Colors.red, // inkwell color
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                          size: 22.0,
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Container(
                        width: _deviceWidth * 0.85,
                        height: _deviceHeight * 0.40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                color: Colors.blue,
              ),
              Container(
                height: 400,
                color: Colors.green,
              )
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
