import 'package:flutter/material.dart';

import '../models/event.dart';
import '../models/survey.dart';
import '../widgets/question_card.dart';
import '../widgets/survey_input.dart';
import '../widgets/survey_list.dart';
import '../widgets/survey_rating.dart';

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
    with SingleTickerProviderStateMixin {
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
    _controller.dispose();
    super.dispose();
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

  Widget _buildOptions(BuildContext context, double deviceWidth) {
    int _selectedQuestion = _currentPage.floor();
    InputType _inputType = _survey.questions[_selectedQuestion].rules.inputType;
    Question _question = _survey.questions.elementAt(_selectedQuestion);

    switch (_inputType) {
      case InputType.list:
        return SurveyList(question: _question);
      case InputType.rating:
        return SurveyRating(question: _question);
      case InputType.input:
        return SurveyInput(question: _question);
      default:
        return Container();
    }
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
                          color: Color(0xFFEAEEF8),
                          width: _deviceWidth,
                          height: _deviceHeight * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: _buildOptions(context, _deviceWidth),
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
