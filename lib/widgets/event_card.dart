import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../styles/colors.dart';
import '../utils/constants.dart';

class EventCard extends StatelessWidget {
  final double deviceWidth;
  final double deviceHeight;
  final Event event;

  const EventCard({
    Key key,
    this.deviceWidth,
    this.deviceHeight,
    @required this.event,
  })  : assert(event != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          EVENT_DETAILS_ROUTE,
          arguments: EventDetailsArguments(event: event),
        );
      },
      splashColor: Colors.transparent,
      child: Container(
        width: deviceWidth * 0.85,
        height: deviceHeight * 0.40,
        decoration: BoxDecoration(
          gradient: event1,
          borderRadius: BorderRadius.circular(25.0),
          image: new DecorationImage(
            image: new AssetImage(event.image),
            fit: BoxFit.cover,
          ),
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
                      horizontal: 20.0,
                      vertical: 4.0,
                    ),
                    child: Text(
                      new DateFormat.MMMEd().format(event.date),
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: Text(
                      event.title,
                      style: Theme.of(context).textTheme.subhead,
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
                    color: Color(0xFFFEEDF3).withOpacity(0.25), // button color
                    child: InkWell(
                      splashColor: Colors.transparent, // inkwell color
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
    );
  }
}
