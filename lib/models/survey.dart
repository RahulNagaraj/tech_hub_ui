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
    @required this.label,
    @required this.value,
    this.subTitle: '',
    this.avatar: '',
    this.infoIcon: false,
    this.infoText: '',
  });
}

class RatingOption {
  final String label;
  final bool infoIcon;
  final String infoText;

  RatingOption({
    @required this.label,
    this.infoIcon: false,
    this.infoText: '',
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
  final RatingOption options;
  final int scale;
  final String icon;

  RatingRule({
    @required this.options,
    this.scale: 5,
    this.icon: 'star',
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

final List<ListOption> _listOptions1 = List.generate(
    4,
    (int index) =>
        new ListOption(label: 'Label ${index + 1}', value: 'Value $index'));

final List<ListOption> _listOptions2 = List.generate(
    3,
    (int index) =>
        new ListOption(label: 'Label ${index + 1}', value: 'Value $index'));

final RatingOption _ratingOption = new RatingOption(label: 'Rate your answer');

final ListRule _listRule1 =
    new ListRule(options: _listOptions1, showAvatar: false);

final ListRule _listRule2 =
    new ListRule(options: _listOptions2, showAvatar: true);

final InputRule _inputRule = new InputRule(
    type: InputRuleType.text, label: 'Your answer', name: 'question3');

final RatingRule _ratingRule = new RatingRule(options: _ratingOption);

final Rule _rule1 = new Rule(inputType: InputType.list, listRule: _listRule1);

final Rule _rule2 = new Rule(inputType: InputType.list, listRule: _listRule2);

final Rule _rule3 = new Rule(inputType: InputType.input, inputRule: _inputRule);

final Rule _rule4 =
    new Rule(inputType: InputType.rating, ratingRule: _ratingRule);

final List<Question> _questions = [
  new Question(
    title: 'Which Painter also designed a flying machine?',
    name: 'question1',
    rules: _rule1,
  ),
  new Question(
    title: 'When did the post mordern art history begin?',
    name: 'question2',
    rules: _rule2,
  ),
  new Question(
    title: 'Name the artist that cut off part of his ear',
    name: 'question3',
    rules: _rule3,
  ),
  new Question(
    title: 'Which artist was known for drip painting?',
    name: 'question4',
    rules: _rule4,
  )
];

final Survey survey = new Survey(
  id: '1234556',
  eventId: '123456',
  title: 'Survey 1',
  questions: _questions,
  active: true,
);
