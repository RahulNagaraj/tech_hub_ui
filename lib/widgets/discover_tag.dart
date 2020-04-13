import 'package:flutter/material.dart';

import '../models/discover_tag.dart';

class DiscoverTag extends StatelessWidget {
  final Tag tag;
  final double deviceWidth;

  const DiscoverTag({Key key, @required this.tag, @required this.deviceWidth})
      : assert(tag != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Material(
        elevation: 1.0,
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          width: deviceWidth * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white70,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tag.color.withOpacity(0.15),
                ),
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  tag.iconData,
                  color: tag.color,
                  size: 20.0,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                tag.title.toUpperCase(),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: tag.color,
                      fontWeight: FontWeight.w900,
                      fontSize: 12.0,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
