import 'package:flutter/material.dart';

import '../models/discover_tag.dart';
import '../models/event.dart';
import '../utils/constants.dart';
import '../widgets/circular_icon_button.dart';
import '../widgets/discover_tag.dart';
import '../widgets/event_card.dart';
import '../widgets/heading.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;

    List<Widget> _buildEventCards() {
      List<Widget> _eventCards = new List();
      for (int i = 0; i < allEvents.length; i++) {
        Event event = allEvents[i];
        _eventCards.add(
          EventCard(
            deviceWidth: _deviceWidth,
            deviceHeight: _deviceHeight,
            event: event,
          ),
        );
        // So that we don't add extra width of 16 px to the last card
        if (i != allEvents.length - 1) {
          _eventCards.add(
            SizedBox(
              width: 16.0,
            ),
          );
        }
      }
      return _eventCards;
    }

    List<Widget> _buildDiscoverTags() {
      List<Widget> _discoverTags = new List();
      for (var tag in tags) {
        _discoverTags.add(
          DiscoverTag(
            tag: tag,
            deviceWidth: _deviceWidth,
          ),
        );
        if (tag.id != tags.length) {
          _discoverTags.add(
            SizedBox(
              width: 12.0,
            ),
          );
        }
      }
      return _discoverTags;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(HOME_PAGE_APP_BAR_TITLE),
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
                      child: CircularIconButton(
                        iconData: Icons.filter_list,
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Heading(heading: 'Discover'),
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
                    children: _buildDiscoverTags(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Heading(heading: 'Upcoming'),
                    ),
                    Expanded(
                      flex: 2,
                      child: CircularIconButton(
                        iconData: Icons.arrow_forward,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'upcoming...',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
