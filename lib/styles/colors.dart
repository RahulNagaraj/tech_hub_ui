import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFFE3E4EA);
final Color primaryTextColor = Color(0xFF080411);
final Color secondaryTextColor = Color(0xFF213EA1);
final Color tertiaryTextColor = Color(0xFFFC0E58);
final Color tertiaryTintColor = Color(0xFFFEEDF3);
final Color greyTextColor = Color(0xFFB9B8C7);
final Color brownTextColor = Color(0xFF513C50);
final Color darkBlueColor = Color(0xFF09125F);

final LinearGradient event1 = LinearGradient(
  colors: [secondaryTextColor, tertiaryTextColor],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

final LinearGradient event2 = LinearGradient(
  colors: [tertiaryTextColor, brownTextColor],
  begin: Alignment.topRight,
  end: Alignment.bottomRight,
);

final LinearGradient event3 = LinearGradient(
  colors: [secondaryTextColor, tertiaryTextColor],
  begin: Alignment.topLeft,
  end: Alignment.topRight,
);

final LinearGradient event4 = LinearGradient(
  colors: [secondaryTextColor, tertiaryTextColor],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);
