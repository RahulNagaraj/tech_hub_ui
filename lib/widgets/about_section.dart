import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../styles/colors.dart';

class AboutSection extends StatelessWidget {
  final Event event;
  final String name;

  const AboutSection({Key key, @required this.name, @required this.event})
      : assert(name != null),
        assert(event != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;

    Widget _buildSummary(IconData iconData, String text) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            size: 28.0,
            color: primaryTextColor.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: primaryTextColor.withOpacity(0.5)),
            ),
          ),
        ],
      );
    }

    Widget _buildSummaryInfo() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _buildSummary(Icons.people, '297 Guests'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
            ),
            child:
                _buildSummary(Icons.location_on, event.locationDetails.address),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: _buildSummary(Icons.calendar_today,
                new DateFormat.MMMEd().format(event.date)),
          ),
        ],
      );
    }

    Widget _buildSectionHeader(String headerText) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            headerText,
            style: Theme.of(context).textTheme.body2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      );
    }

    Widget _buildSectionBody(String bodyText) {
      return Text(
        bodyText,
        style: Theme.of(context)
            .textTheme
            .body2
            .copyWith(fontSize: 18.0, color: primaryTextColor.withOpacity(0.5)),
      );
    }

    Widget _buildEventDescription() {
      return Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: 4.0,
              ),
              child: _buildSectionHeader('About the event'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 4.0,
              ),
              child: _buildSectionBody(event.description),
            ),
          ],
        ),
      );
    }

    Widget _buildEventLocation() {
      return Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                  bottom: 4.0,
                ),
                child: _buildSectionHeader('Location')),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.black.withAlpha(50),
                ),
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> _buildKeyHighlightCard(double _containerWidth) {
      List<Widget> cards = new List();
      int keyHighlightLength = event.keyHighlights.length;
      for (int i = 0; i < keyHighlightLength; i++) {
        KeyHighlight keyHighlight = event.keyHighlights[i];
        double left = 0 + (i * (0.90 * _containerWidth) / keyHighlightLength);
        double width =
            ((keyHighlightLength - i) / keyHighlightLength) * _containerWidth +
                i *
                    ((_containerWidth / keyHighlightLength) -
                        0.9 * (_containerWidth / keyHighlightLength));
        cards.add(
          Positioned(
            top: 0.0,
            bottom: 0.0,
            left: left,
            child: Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              decoration: BoxDecoration(
                color: keyHighlightCardColors[i],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          event.image,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 4.0,
                        ),
                        child: Text(
                          keyHighlight.firstName,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          keyHighlight.topic,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return cards;
    }

    Widget _buildEventKeyHighlights() {
      final _containerWidth = _deviceWidth - 40.0 - 32.0;
      return Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: _buildSectionHeader('Key Highlights')),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                height: 250,
                width: _deviceWidth,
                decoration: BoxDecoration(
                  gradient: keyHighlightsGradient,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Today\'s ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                          fontSize: 18.0,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'Speakers',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 150,
                        width: _containerWidth,
                        child: Stack(
                          alignment: Alignment.center,
                          children: _buildKeyHighlightCard(_containerWidth),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        // This Builder is needed to provide a BuildContext that is "inside"
        // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
        // find the NestedScrollView.
        builder: (BuildContext context) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            // The "controller" and "primary" members should be left
            // unset, so that the NestedScrollView can control this
            // inner scroll view.
            // If the "controller" property is set, then this scroll
            // view will not be associated with the NestedScrollView.
            // The PageStorageKey should be unique to this ScrollView;
            // it allows the list to remember its scroll position when
            // the tab view is not on the screen.
            key: PageStorageKey<String>(name),
            slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber above.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(20.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildSummaryInfo(),
                            _buildEventDescription(),
                            _buildEventLocation(),
                            _buildEventKeyHighlights(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
