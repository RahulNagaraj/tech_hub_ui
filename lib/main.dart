import 'package:flutter/material.dart';
import 'package:techhubui/utils/constants.dart';

import './app.dart';
import './pages/event_details.dart';
import './styles/theme.dart';

void main() => runApp(TechHub());

class TechHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: Styles.themeData(),
      routes: {
        EVENT_DETAILS_ROUTE: (context) => EventDetailsPage(),
      },
      home: App(),
    );
  }
}
