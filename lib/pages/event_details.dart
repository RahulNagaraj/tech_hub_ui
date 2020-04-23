import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';

import '../models/event.dart';
import '../styles/colors.dart';
import '../widgets/about_section.dart';
import '../widgets/speakers_list.dart';
import '../widgets/survey_section.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);
  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  PaletteGenerator paletteGenerator;
  final _tabs = [
    'ABOUT',
    'SPEAKERS',
    'SURVEY',
  ];

  @override
  void initState() {
    super.initState();
    _updatePaletteColor();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _updatePaletteColor() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(widget.event.image),
      maximumColorCount: 32,
    );
    setState(() {});
  }

  Color getIconColor(bool innerBoxIsScrolled) {
    if (innerBoxIsScrolled) {
      return Colors.black;
    } else {
      if (paletteGenerator != null &&
          paletteGenerator.lightMutedColor != null) {
        return paletteGenerator.lightMutedColor.color;
      } else {
        return Colors.black;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    Widget _buildFlexibleSpaceBar(bool innerBoxIsScrolled) {
      return FlexibleSpaceBar(
        stretchModes: <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        centerTitle: true,
        title: !innerBoxIsScrolled
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 78.0,
                    bottom: 32.0,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              new DateFormat.MMMEd().format(widget.event.date),
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        TextSpan(text: '\n'),
                        TextSpan(
                          text: widget.event.title,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Text(''),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              widget.event.image,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );
    }

    Widget _buildTabBar() {
      return TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: tabTextColor,
        unselectedLabelColor: Colors.white,
        labelStyle: Theme.of(context)
            .textTheme
            .subtitle
            .copyWith(fontWeight: FontWeight.w900, letterSpacing: 1.0),
        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .subtitle
            .copyWith(letterSpacing: 1.0, fontWeight: FontWeight.w400),
        // These are the widgets to put in each tab in the tab bar.
        tabs: _tabs
            .map(
              (String name) => Tab(
                text: name,
              ),
            )
            .toList(),
      );
    }

    Widget _buildSliverAppBar(bool innerBoxIsScrolled) {
      return SliverAppBar(
        backgroundColor: (paletteGenerator != null &&
                paletteGenerator.lightMutedColor != null)
            ? paletteGenerator?.lightMutedColor?.color
            : backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 28.0,
            color: getIconColor(innerBoxIsScrolled),
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              size: 28.0,
              color: getIconColor(innerBoxIsScrolled),
            ),
            onPressed: () => {},
          ),
        ],
        centerTitle: true,
        title: innerBoxIsScrolled
            ? Text(widget.event.title)
            : const Text(''), // This is the title in the app bar.
        pinned: true,
        expandedHeight: screenHeight * 0.55,
        flexibleSpace: _buildFlexibleSpaceBar(innerBoxIsScrolled),
        // The "forceElevated" property causes the SliverAppBar to show
        // a shadow. The "innerBoxIsScrolled" parameter is true when the
        // inner scroll view is scrolled beyond its "zero" point, i.e.
        // when it appears to be scrolled below the SliverAppBar.
        // Without this, there are cases where the shadow would appear
        // or not appear inappropriately, because the SliverAppBar is
        // not actually aware of the precise position of the inner
        // scroll views.
        forceElevated: innerBoxIsScrolled,
        bottom: _buildTabBar(),
      );
    }

    Widget _buildTabBarView() {
      return TabBarView(
        // These are the contents of the tab views, below the tabs.
        children: _tabs.map((String name) {
          if (name == _tabs[0]) {
            return AboutSection(
              name: name,
              event: widget.event,
            );
          } else if (name == _tabs[1]) {
            return SpeakersList(
              name: name,
              event: widget.event,
            );
          } else if (name == _tabs[2]) {
            return SurveySection(
              name: name,
              event: widget.event,
            );
          }
          return null;
        }).toList(),
      );
    }

    return Hero(
      tag: widget.event.title,
      transitionOnUserGestures: true,
      child: Scaffold(
        body: DefaultTabController(
          length: _tabs.length,
          child: NestedScrollView(
            physics: BouncingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: _buildSliverAppBar(innerBoxIsScrolled),
                ),
              ];
            },
            body: _buildTabBarView(),
          ),
        ),
      ),
    );
  }
}
