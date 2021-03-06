import 'package:flutter/material.dart';

//final Color backgroundColor = Color(0xFFE3E4EA);
final Color backgroundColor = Color(0xFFF3F2F3);
final Color primaryTextColor = Color(0xFF080411);
final Color secondaryTextColor = Color(0xFF213EA1);
final Color tertiaryTextColor = Color(0xFFFC0E58);
final Color tertiaryTintColor = Color(0xFFFEEDF3);
final Color greyTextColor = Color(0xFFB9B8C7);
final Color brownTextColor = Color(0xFF513C50);
final Color darkBlueColor = Color(0xFF09125F);
final Color lightOrangeColor = Color(0xFFC24E59);
final Color tabTextColor = Color(0xFF2E88FF);
final Color tabBackgroundColor = Color(0xFFECEBEE);
//final Color greyTextColor = Color(0xFFB3B1BE);
final MaterialColor shadesOfGrey = MaterialColor(0xFFB9B8C7, {
  50: Color(0xFFF3F2F3), // backgroundColor
  100: Color(0xFFE3E4EA),
  200: Color(0xFFB9B8C7),
  300: Color(0xFFB3B1BE),
  400: Color(0xFFBDBCBD),
});

final List<Color> keyHighlightCardColors = [
  Color(0xFFDEE2EA),
  Color(0xFFFC6681),
  Color(0xFF6C63FF),
];

final Map<String, Color> speakerCardColor = {
  'expanded': tabTextColor,
  'collapsed': Color(0xFFFFFFFF)
};

final LinearGradient event1 = LinearGradient(
  colors: [secondaryTextColor, tertiaryTextColor],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

final LinearGradient keyHighlightsGradient = LinearGradient(
  colors: [Color(0xFFA0D8D9), Color(0xFFDEE2EA), Color(0xFFB5A4B1)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
