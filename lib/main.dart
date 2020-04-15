import 'package:flutter/material.dart';

import './app.dart';
import './models/event.dart';
import './pages/event_details.dart';
import './styles/theme.dart';
import './utils/constants.dart';

void main() => runApp(TechHub());

class TechHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: Styles.themeData(),
      onGenerateRoute: (settings) {
        if (settings.name == EVENT_DETAILS_ROUTE) {
          final EventDetailsArguments args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return EventDetailsPage(
                event: args.event,
              );
            },
          );
        }
        return null;
      },
      home: App(),
    );
  }
}
