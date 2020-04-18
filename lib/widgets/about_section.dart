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
      return Text(
        headerText,
        style: Theme.of(context).textTheme.body2.copyWith(
              fontWeight: FontWeight.w600,
            ),
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
                color: Colors.blueGrey,
                height: 250,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildEventKeyHighlights() {
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
                child: _buildSectionHeader('Key Highlights')),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                color: Colors.blueGrey,
                height: 250,
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
