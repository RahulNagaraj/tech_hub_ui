import 'package:flutter/material.dart';

import '../models/survey.dart';

class SurveyList extends StatelessWidget {
  final Question question;

  const SurveyList({Key key, @required this.question}) : super(key: key);

  List<Widget> _buildListOptions(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final ListRule _listRules = question.rules.listRules;
    List<Widget> _listOptions = new List();

    _listOptions = _listRules.options.map((ListOption _option) {
      return GestureDetector(
        onTap: () {
          print(_option.label);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Material(
            elevation: 2.0,
            child: Container(
              width: _deviceWidth - 80.0,
              height: 60.0,
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
                          _option.label,
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
        ),
      );
    }).toList();

    return _listOptions;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildListOptions(context),
    );
  }
}
