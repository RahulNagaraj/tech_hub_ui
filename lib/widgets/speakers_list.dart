import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/event.dart';
import '../models/speaker.dart';
import '../styles/colors.dart';

class SpeakerExpansion {
  bool isExpanded;
  final Speaker speaker;

  SpeakerExpansion({this.isExpanded = false, @required this.speaker});
}

class SpeakersList extends StatefulWidget {
  final Event event;
  final String name;

  const SpeakersList({Key key, this.event, this.name})
      : assert(name != null),
        assert(event != null),
        super(key: key);

  @override
  _SpeakersListState createState() => _SpeakersListState();
}

class _SpeakersListState extends State<SpeakersList> {
  final List<SpeakerExpansion> _speakerExpansion = new List();
  @override
  void initState() {
    super.initState();
    widget.event.speakers.forEach((Speaker speaker) {
      _speakerExpansion.add(SpeakerExpansion(speaker: speaker));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            key: PageStorageKey<String>(widget.name),
            semanticChildCount: _speakerExpansion.length,
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(20.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final int itemIndex = index ~/ 2;
                      if (index.isOdd) {
                        return Divider(
                          height: 16.0,
                          color: Colors.transparent,
                        );
                      }
                      return Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          height: _deviceHeight * 0.1,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: _speakerExpansion[itemIndex].isExpanded
                                ? speakerCardColor['expanded']
                                : speakerCardColor['collapsed'],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(widget.event.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _speakerExpansion[itemIndex]
                                              .speaker
                                              .firstName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle
                                              .copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                              ),
                                        ),
                                        Text(
                                          _speakerExpansion[itemIndex]
                                              .speaker
                                              .designation,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_drop_down_circle,
                                      color: _speakerExpansion[itemIndex]
                                              .isExpanded
                                          ? speakerCardColor['collapsed']
                                          : speakerCardColor['expanded'],
                                      size: 28.0,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _speakerExpansion[itemIndex]
                                                .isExpanded =
                                            !_speakerExpansion[itemIndex]
                                                .isExpanded;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    semanticIndexCallback: (Widget widget, int localIndex) {
                      if (localIndex.isOdd) {
                        return localIndex ~/ 2;
                      }
                      return null;
                    },
                    childCount: math.max(0, _speakerExpansion.length * 2 - 1),
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
