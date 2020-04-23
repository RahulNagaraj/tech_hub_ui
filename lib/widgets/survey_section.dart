import 'package:flutter/material.dart';

import '../models/event.dart';
import '../models/survey.dart';
import '../widgets/question_card.dart';

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

  void _onPreviousQuestionTap(int questionIndex) {
    if (questionIndex == 0) return null;
    _controller.animateToPage(
      questionIndex - 1,
      duration: const Duration(
        milliseconds: 420,
      ),
      curve: Curves.easeIn,
    );
  }

  void _onNextQuestionTap(int questionIndex) {
    if (questionIndex == _survey.questions.length - 1) return null;
    _controller.animateToPage(
      questionIndex + 1,
      duration: const Duration(
        milliseconds: 420,
      ),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildQuestionSection(double deviceHeight) {
    return Material(
      elevation: 12.0,
      child: Container(
        height: deviceHeight * 0.4,
        child: PageView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: _survey.questions.length,
          controller: _controller,
          itemBuilder: (context, index) {
            return QuestionCard(
              questionIndex: index,
              currentPage: _currentPage,
              onNextQuestionTap: _onNextQuestionTap,
              onPreviousQuestionTap: _onPreviousQuestionTap,
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildListOptions(int questionIndex, double deviceWidth) {
    List<Widget> _listOptions = new List();
    _listOptions =
        _survey.questions[questionIndex].rules.listRule.options.map((option) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 2.0,
          child: Container(
            width: deviceWidth - 80,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        option.label,
                        softWrap: true,
                        style: Theme.of(context).textTheme.subtitle.copyWith(
                              color: Color(0xFFFCFCFF),
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
    return _listOptions;
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
                        _buildQuestionSection(_deviceHeight),
                        Container(
                          color: Color(0xFF1047FF),
                          width: _deviceWidth,
                          height: _deviceHeight * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildListOptions(
                                  _currentPage.floor(), _deviceWidth),
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
