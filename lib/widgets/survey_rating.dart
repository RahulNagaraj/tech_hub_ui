import 'package:flutter/material.dart';

import '../models/survey.dart';
import '../widgets/slider_widget.dart';

class SurveyRating extends StatelessWidget {
  final Question question;

  const SurveyRating({Key key, @required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RatingRule _ratingRules = question.rules.ratingRules;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SliderWidget(
          max: _ratingRules.scale,
          min: 0,
          fullWidth: true,
        ),
      ],
    );
  }
}
