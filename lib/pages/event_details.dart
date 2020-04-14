import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../styles/colors.dart';

class EventDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventDetailsArguments args =
        ModalRoute.of(context).settings.arguments;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.55,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage(args.event.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 36.0,
                    left: 8.0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: greyTextColor.withOpacity(0.25),
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.close,
                          size: 24.0,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 36.0,
                    right: 8.0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: greyTextColor.withOpacity(0.25),
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.favorite_border,
                          size: 24.0,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 72.0,
                    left: 16.0,
                    child: Text(
                      new DateFormat.MMMEd().format(args.event.date),
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                  Positioned(
                    bottom: 32.0,
                    left: 16.0,
                    child: Text(
                      args.event.title,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
