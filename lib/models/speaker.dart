import 'package:flutter/foundation.dart';

import './event.dart';

class Speaker {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final List<String> topics;
  final List<String> hobbies;
  final List<Event> events;

  Speaker({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    this.avatar,
    @required this.topics,
    @required this.hobbies,
    @required this.events,
  })  : assert(id != null),
        assert(firstName != null),
        assert(lastName != null),
        assert(email != null),
        assert(topics != null),
        assert(hobbies != null),
        assert(events != null);
}
