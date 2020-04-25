import 'package:flutter/material.dart';

import './ensure_visible_when_focused.dart';
import '../models/survey.dart';

class SurveyInput extends StatefulWidget {
  final Question question;

  const SurveyInput({Key key, @required this.question}) : super(key: key);

  @override
  _SurveyInputState createState() => _SurveyInputState();
}

class _SurveyInputState extends State<SurveyInput> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
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

  Widget _buildInputOptions(BuildContext context) {
    final InputRule _inputRules = widget.question.rules.inputRules;
    final String hintText = _inputRules.label;

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
                    onChanged: (String value) {
                      // TODO: Perform logic to update value
                      print(value);
                    },
                    onEditingComplete: () {
                      _focusNode.unfocus(focusPrevious: false);
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildInputOptions(context),
    );
  }
}
