import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'styles/theme.dart';

void main() => runApp(TechHub());

class TechHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tech Hub',
      theme: Styles.themeData(),
      home: HomePage(),
    );
  }
}
