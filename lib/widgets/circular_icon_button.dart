import 'package:flutter/material.dart';

import '../styles/colors.dart';

class CircularIconButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final double iconSize;
  final Function onTap;

  const CircularIconButton(
      {Key key,
      @required this.iconData,
      this.color = Colors.white54,
      this.iconSize = 22.0,
      this.onTap})
      : assert(iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              offset: Offset(1.0, 1.0),
              blurRadius: 1.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
          vertical: 3.0,
        ),
        child: Icon(
          iconData,
          color: tertiaryTextColor,
          size: iconSize,
        ),
      ),
      onPressed: () {},
    );
  }
}
