import 'package:flutter/material.dart';

import '../models/survey.dart';
import '../styles/colors.dart';

class QuestionCard extends StatelessWidget {
  final int questionIndex;
  final double currentPage;
  final Function onPreviousQuestionTap;
  final Function onNextQuestionTap;

  const QuestionCard({
    Key key,
    @required this.questionIndex,
    @required this.currentPage,
    @required this.onPreviousQuestionTap,
    @required this.onNextQuestionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 24.0,
                      color: questionIndex == 0 ? greyTextColor : Colors.black,
                    ),
                    onPressed: () => onPreviousQuestionTap(questionIndex),
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
                            text: '${questionIndex + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(color: Colors.black),
                          ),
                          TextSpan(
                            text: ' / ',
                            style: Theme.of(context).textTheme.body2.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          TextSpan(
                            text: '${survey.questions.length}',
                            style: Theme.of(context).textTheme.body2.copyWith(
                                  fontWeight: FontWeight.w700,
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
                      color: questionIndex == survey.questions.length - 1
                          ? greyTextColor
                          : Colors.black,
                    ),
                    onPressed: () => onNextQuestionTap(questionIndex),
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
                    value: (currentPage + 1) / survey.questions.length,
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
                    survey.questions[questionIndex].title,
                    softWrap: true,
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
