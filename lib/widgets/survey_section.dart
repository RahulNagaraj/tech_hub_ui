import 'package:flutter/material.dart';

import './ensure_visible_when_focused.dart';
import '../models/event.dart';
import '../models/survey.dart';
import '../widgets/question_card.dart';
import '../widgets/slider_widget.dart';

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
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();
  static final TextEditingController _textEditingController =
      new TextEditingController();

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

    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_focusNodeListener);

    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    if (_focusNode.hasFocus) {
      print('TextField got the focus');
    } else {
      print('TextField lost the focus');
    }
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

  Widget _buildListOptions(int questionIndex, double deviceWidth) {
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
              gradient: new LinearGradient(
                colors: [
                  const Color(0xFF00c6ff),
                  const Color(0xFF0072ff),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.00),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _listOptions,
    );
  }

  Widget _buildInputOptions(BuildContext context, int questionIndex) {
    Question _question = _survey.questions[questionIndex];
    final String hintText = _question.rules.inputRule.label;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                EnsureVisibleWhenFocused(
                  focusNode: _focusNode,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: Theme.of(context).textTheme.subhead.copyWith(
                            color: Colors.black.withOpacity(0.7),
                          ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF00c6ff),
                          width: 3.0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.7),
                          width: 3.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    ),
                    focusNode: _focusNode,
                    controller: _textEditingController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Color(0xFF00c6ff),
                    cursorWidth: 3.0,
                    style: Theme.of(context).textTheme.subhead.copyWith(
                          color: Colors.black.withOpacity(0.7),
                        ),
                    onChanged: (value) {
                      // TODO: Perform logic to update value
                      print(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingOptions(BuildContext context, int questionIndex) {
    int max = _survey.questions[questionIndex].rules.ratingRule.scale;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SliderWidget(
          max: max,
          min: 0,
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildOptions(BuildContext context, double deviceWidth) {
    InputType _inputType =
        _survey.questions[_currentPage.floor()].rules.inputType;
    switch (_inputType) {
      case InputType.list:
        return _buildListOptions(_currentPage.floor(), deviceWidth);
      case InputType.rating:
        return _buildRatingOptions(context, _currentPage.floor());
      case InputType.input:
        return InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _buildInputOptions(context, _currentPage.floor()),
        );
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
