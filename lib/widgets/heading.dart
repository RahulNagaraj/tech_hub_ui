import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String heading;

  const Heading({Key key, this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline,
    );
  }
}
