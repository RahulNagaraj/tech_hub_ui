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
  void dispose() {
    super.dispose();
  }

  List<Widget> _buildSpeakerTopicChips(BuildContext context, int index) {
    List<Widget> topicChips = new List();
    List<String> topics = _speakerExpansion[index].speaker.topics;
    for (int i = 0; i < topics.length; i++) {
      String topic = topics[i];
      topicChips.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: Chip(
            label: Text(topic),
            backgroundColor: tabTextColor.withOpacity(0.4),
          ),
        ),
      );
    }
    return topicChips;
  }

  Widget _buildIconButton(bool isExpanded, int index) {
    return Transform.rotate(
      angle: isExpanded ? 180 * (math.pi / 180) : 0,
      child: IconButton(
        icon: Icon(
          Icons.arrow_drop_down_circle,
          color: isExpanded
              ? speakerCardColor['collapsed']
              : speakerCardColor['expanded'],
          size: 32.0,
        ),
        onPressed: () {
          setState(() {
            _speakerExpansion[index].isExpanded =
                !_speakerExpansion[index].isExpanded;
          });
        },
      ),
    );
  }

  Widget _buildExpandedRow(
      double deviceHeight, double deviceWidth, int itemIndex) {
    return Expanded(
      child: Container(
        height: deviceHeight * 0.1,
        width: deviceWidth,
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
          color: speakerCardColor['collapsed'],
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
          ),
        ),
        child: Row(
          children: _buildSpeakerTopicChips(context, itemIndex),
        ),
      ),
    );
  }

  Widget _buildSpeakerDesignation(int itemIndex) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 4.0,
            ),
            child: Text(
              _speakerExpansion[itemIndex].speaker.firstName,
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontSize: 18.0,
                    color: Colors.black.withOpacity(0.7),
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 4.0,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: _speakerExpansion[itemIndex].speaker.company,
                    style: Theme.of(context).textTheme.body2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  TextSpan(text: ' '),
                  TextSpan(
                    text: _speakerExpansion[itemIndex].speaker.business,
                    style: Theme.of(context).textTheme.body2.copyWith(
                          fontWeight: FontWeight.w600,
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

  Widget _buildSpeakerDetailsRow(int itemIndex) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  widget.event.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildSpeakerDesignation(itemIndex),
        ],
      ),
    );
  }

  Widget _buildExpandIconButton(int itemIndex) {
    return Row(
      children: <Widget>[
        _buildIconButton(_speakerExpansion[itemIndex].isExpanded, itemIndex)
      ],
    );
  }

  Widget _buildSpeakerListItem(BuildContext context, int itemIndex) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;
    final BorderRadius _borderRadius = BorderRadius.circular(16.0);

    return Material(
      elevation: 4,
      borderRadius: _borderRadius,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        height: _speakerExpansion[itemIndex].isExpanded
            ? 2 * _deviceHeight * 0.1
            : _deviceHeight * 0.1,
        decoration: BoxDecoration(
          color: speakerCardColor['collapsed'],
          borderRadius: _borderRadius,
        ),
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 650),
              height: _deviceHeight * 0.1,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: _speakerExpansion[itemIndex].isExpanded
                    ? speakerCardColor['expanded']
                    : speakerCardColor['collapsed'],
                borderRadius: _borderRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildSpeakerDetailsRow(itemIndex),
                  _buildExpandIconButton(itemIndex),
                ],
              ),
            ),
            if (_speakerExpansion[itemIndex].isExpanded)
              _buildExpandedRow(_deviceHeight, _deviceWidth, itemIndex)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      return _buildSpeakerListItem(context, itemIndex);
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
