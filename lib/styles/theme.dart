import 'package:flutter/material.dart';

import 'colors.dart';

class Styles {
  static ThemeData themeData() {
    return ThemeData(
      brightness: Brightness.light,
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Raleway',
      primaryColor: backgroundColor,
      appBarTheme: AppBarTheme(
          elevation: 5.0,
          color: Colors.white,
          textTheme: TextTheme(
              title: TextStyle(
                  color: primaryTextColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold))),
      textTheme: TextTheme(
        headline: TextStyle(
            color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.w700),
        title: TextStyle(
            color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.w700),
        subhead: TextStyle(
            color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w600),
        subtitle: TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
        body2: TextStyle(
            color: greyTextColor, fontSize: 16.0, fontWeight: FontWeight.w400),
        caption: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
    );
  }
}
