import 'package:flutter/material.dart';

import '../styles/colors.dart';

class Tag {
  final int id;
  final String title;
  final IconData iconData;
  final Color color;

  Tag({
    @required this.id,
    @required this.title,
    @required this.iconData,
    @required this.color,
  })  : assert(id != null),
        assert(title != null),
        assert(iconData != null),
        assert(color != null);
}

final List<Tag> tags = [
  Tag(
    id: 1,
    title: 'Events',
    iconData: Icons.event,
    color: tertiaryTextColor,
  ),
  Tag(
    id: 2,
    title: 'Volunteer',
    iconData: Icons.supervisor_account,
    color: secondaryTextColor,
  ),
  Tag(
    id: 3,
    title: 'Birthdays',
    iconData: Icons.cake,
    color: lightOrangeColor,
  ),
];
