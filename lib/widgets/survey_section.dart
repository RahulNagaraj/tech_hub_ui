import 'package:flutter/material.dart';

import '../models/event.dart';
import '../models/survey.dart';
import '../styles/colors.dart';

class SurveySection extends StatefulWidget {
  final Event event;
  final String name;

  const SurveySection({Key key, @required this.event, @required this.name})
      : assert(event != null),
        assert(name != null),
        super(key: key);

  @override
  _SurveySectionState createState() => _SurveySectionState();
}

class _SurveySectionState extends State<SurveySection>
    with TickerProviderStateMixin {
  Survey _survey = survey;
  double _currentPage;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _currentPage = 0.0;

    _controller = PageController(
      initialPage: 0,
    );

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final double _deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (BuildContext context) {
        return CustomScrollView(
          physics: BouncingScrollPhysics(),
          key: PageStorageKey<String>(widget.name),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          elevation: 12.0,
                          child: Container(
                            height: _deviceHeight * 0.4,
                            child: PageView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: _survey.questions.length,
                              controller: _controller,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: const EdgeInsets.all(0.0),
                                  elevation: 0.0,
                                  color: Colors.white.withOpacity(1.0),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(4.0),
                                      bottomRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  child: Container(
                                    width: _deviceWidth,
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.arrow_back_ios,
                                                  size: 24.0,
                                                  color: index == 0
                                                      ? greyTextColor
                                                      : Colors.black,
                                                ),
                                                onPressed: index == 0
                                                    ? null
                                                    : () {
                                                        _controller
                                                            .animateToPage(
                                                          index - 1,
                                                          duration:
                                                              const Duration(
                                                            milliseconds: 420,
                                                          ),
                                                          curve: Curves.easeIn,
                                                        );
                                                      },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '${index + 1}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      TextSpan(
                                                        text: ' / ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .body2
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            '${_survey.questions.length}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .body2
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 24.0,
                                                  color: index ==
                                                          _survey.questions
                                                                  .length -
                                                              1
                                                      ? greyTextColor
                                                      : Colors.black,
                                                ),
                                                onPressed: index ==
                                                        _survey.questions
                                                                .length -
                                                            1
                                                    ? null
                                                    : () {
                                                        _controller
                                                            .animateToPage(
                                                          index + 1,
                                                          duration:
                                                              const Duration(
                                                            milliseconds: 420,
                                                          ),
                                                          curve: Curves.easeIn,
                                                        );
                                                      },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: LinearProgressIndicator(
                                                value: (_currentPage + 1) /
                                                    _survey.questions.length,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 72,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: _deviceWidth - 40,
                                              child: Text(
                                                _survey.questions[index].title,
                                                softWrap: true,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF1047FF),
                          width: _deviceWidth,
                          height: _deviceHeight * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Material(
                                    elevation: 2.0,
                                    child: Container(
                                      width: _deviceWidth - 80,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF2157FF),
                                        border: Border(
                                          left: BorderSide(
                                            width: 4.0,
                                            color: Color(0xFFFCFCFF),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Combination of Oil Paint',
                                                  softWrap: true,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle
                                                      .copyWith(
                                                        color:
                                                            Color(0xFFFCFCFF),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Material(
                                    elevation: 2.0,
                                    child: Container(
                                      width: _deviceWidth - 80,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF2157FF),
                                        border: Border(
                                          left: BorderSide(
                                            width: 4.0,
                                            color: Color(0xFFFCFCFF),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Combination of Oil Paint',
                                                  softWrap: true,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle
                                                      .copyWith(
                                                        color:
                                                            Color(0xFFFCFCFF),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Material(
                                    elevation: 2.0,
                                    child: Container(
                                      width: _deviceWidth - 80,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF2157FF),
                                        border: Border(
                                          left: BorderSide(
                                            width: 4.0,
                                            color: Color(0xFFFCFCFF),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Combination of Oil Paint',
                                                  softWrap: true,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle
                                                      .copyWith(
                                                        color:
                                                            Color(0xFFFCFCFF),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Material(
                                    elevation: 2.0,
                                    child: Container(
                                      width: _deviceWidth - 80,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF2157FF),
                                        border: Border(
                                          left: BorderSide(
                                            width: 4.0,
                                            color: Color(0xFFFCFCFF),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Combination of Oil Paint',
                                                  softWrap: true,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle
                                                      .copyWith(
                                                        color:
                                                            Color(0xFFFCFCFF),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
