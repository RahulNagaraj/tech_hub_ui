import 'package:flutter/foundation.dart';

enum InputType {
  input,
  list,
  rating,
}

enum RatingIcon {
  star,
  like,
  thumbsup,
}

enum InputRuleType {
  text,
  number,
}

class ListOption {
  final String label;
  final String value;
  final String subTitle;
  final String avatar;
  final bool infoIcon;
  final String infoText;

  ListOption({
    this.label,
    this.value,
    this.subTitle,
    this.avatar,
    this.infoIcon,
    this.infoText,
  });
}

class RatingOption {
  final String label;
  final bool infoIcon;
  final String infoText;

  RatingOption({
    this.label,
    this.infoIcon,
    this.infoText,
  });
}

class ListRule {
  final List<ListOption> options;
  final bool showAvatar;

  ListRule({
    this.options,
    this.showAvatar,
  });
}

class RatingRule {
  final List<RatingOption> options;
  final int scale;
  final String icon;

  RatingRule({
    this.options,
    this.scale,
    this.icon,
  });
}

class InputRule {
  final InputRuleType type;
  final String label;
  final String name;
  final int maxLength;
  final int minLength;

  InputRule({
    @required this.type,
    @required this.label,
    @required this.name,
    this.maxLength,
    this.minLength,
  });
}

class Rule {
  final InputType inputType;
  final ListRule listRule;
  final RatingRule ratingRule;
  final InputRule inputRule;

  Rule({
    @required this.inputType,
    this.listRule,
    this.ratingRule,
    this.inputRule,
  });
}

class Question {
  final String title;
  final String name;
  final String subTitle;
  final Rule rules;

  Question({
    @required this.title,
    @required this.name,
    this.subTitle,
    @required this.rules,
  });
}

class Survey {
  final String id;
  final String eventId;
  final String title;
  final List<Question> questions;
  final bool active;

  Survey({
    @required this.id,
    @required this.eventId,
    @required this.title,
    @required this.questions,
    @required this.active,
  });
}

final List<ListOption> _listOptions = List.generate(
    4,
    (int index) =>
        new ListOption(label: 'Label ${index + 1}', value: 'Value $index'));

final ListRule _listRule =
    new ListRule(options: _listOptions, showAvatar: false);

final Rule _rule = new Rule(inputType: InputType.list, listRule: _listRule);

final List<Question> _questions = [
  new Question(
    title: 'Which Painter also designed a flying machine?',
    name: 'question1',
    rules: _rule,
  ),
  new Question(
    title: 'When did the post mordern art history begin?',
    name: 'question2',
    rules: _rule,
  ),
  new Question(
    title: 'Name the artist that cut off part of his ear',
    name: 'question3',
    rules: _rule,
  ),
  new Question(
    title: 'Which artist was known for drip painting?',
    name: 'question4',
    rules: _rule,
  )
];

final Survey survey = new Survey(
  id: '1234556',
  eventId: '123456',
  title: 'Survey 1',
  questions: _questions,
  active: true,
);
