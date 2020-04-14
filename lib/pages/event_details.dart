import 'package:flutter/material.dart';

import '../models/event.dart';
import '../utils/constants.dart';

class EventDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventDetailsArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(EVENT_DETAILS_APP_BAR_TITLE),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
