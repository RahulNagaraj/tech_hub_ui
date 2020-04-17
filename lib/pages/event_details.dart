import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';

import '../models/event.dart';
import '../styles/colors.dart';

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

    Widget buildFlexibleSpaceBar(bool innerBoxIsScrolled) {
      print(innerBoxIsScrolled);
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

    Widget buildTabBar() {
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

    Widget buildSliverAppBar(bool innerBoxIsScrolled) {
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
        title: innerBoxIsScrolled
            ? Text(widget.event.title)
            : const Text(''), // This is the title in the app bar.
        pinned: true,
        expandedHeight: screenHeight * 0.55,
        flexibleSpace: buildFlexibleSpaceBar(innerBoxIsScrolled),
        // The "forceElevated" property causes the SliverAppBar to show
        // a shadow. The "innerBoxIsScrolled" parameter is true when the
        // inner scroll view is scrolled beyond its "zero" point, i.e.
        // when it appears to be scrolled below the SliverAppBar.
        // Without this, there are cases where the shadow would appear
        // or not appear inappropriately, because the SliverAppBar is
        // not actually aware of the precise position of the inner
        // scroll views.
        forceElevated: innerBoxIsScrolled,
        bottom: buildTabBar(),
      );
    }

    Widget buildTabBarView() {
      return TabBarView(
        // These are the contents of the tab views, below the tabs.
        children: _tabs.map((String name) {
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
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.people,
                                          size: 28.0,
                                          color:
                                              primaryTextColor.withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                          ),
                                          child: Text(
                                            '200 Guests',
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1
                                                .copyWith(
                                                    color: primaryTextColor
                                                        .withOpacity(0.5)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: 28.0,
                                          color:
                                              primaryTextColor.withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                          ),
                                          child: Text(
                                            widget
                                                .event.locationDetails.address,
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1
                                                .copyWith(
                                                  color: primaryTextColor
                                                      .withOpacity(0.5),
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.calendar_today,
                                          size: 28.0,
                                          color:
                                              primaryTextColor.withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                          ),
                                          child: Text(
                                            new DateFormat.MMMEd()
                                                .format(widget.event.date),
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1
                                                .copyWith(
                                                  color: primaryTextColor
                                                      .withOpacity(0.5),
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 16.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 4.0,
                                          ),
                                          child: Text(
                                            'About the event',
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2
                                                .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4.0,
                                          ),
                                          child: Text(
                                            widget.event.description,
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2
                                                .copyWith(
                                                    fontSize: 18.0,
                                                    color: primaryTextColor
                                                        .withOpacity(0.5)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 16.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 4.0,
                                          ),
                                          child: Text(
                                            'Location',
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2
                                                .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Container(
                                            color: Colors.blueGrey,
                                            height: 250,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 16.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 4.0,
                                          ),
                                          child: Text(
                                            'Key Highlights',
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2
                                                .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Container(
                                            color: Colors.blueGrey,
                                            height: 250,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
        }).toList(),
      );
    }

    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: buildSliverAppBar(innerBoxIsScrolled),
              ),
            ];
          },
          body: buildTabBarView(),
        ),
      ),
    );
  }
}
