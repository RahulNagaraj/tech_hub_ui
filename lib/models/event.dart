import 'package:flutter/foundation.dart';

import 'speaker.dart';

enum LocationType {
  Point,
}

enum Category {
  Events,
  Birthdays,
  Volunteer,
}

class ContactInformation {
  final String email;
  final List<int> mobile;
  final List<int> phone;

  ContactInformation({
    @required this.email,
    this.mobile,
    this.phone,
  }) : assert(email != null);
}

class Organizer {
  final String firstName;
  final String lastName;
  final ContactInformation contactInformation;

  Organizer({
    @required this.firstName,
    @required this.lastName,
    @required this.contactInformation,
  })  : assert(firstName != null),
        assert(lastName != null),
        assert(contactInformation != null);
}

class Location {
  final LocationType locationType;
  final List<double> coordinates;

  Location({
    @required this.locationType,
    @required this.coordinates,
  })  : assert(locationType != null),
        assert(coordinates != null);
}

class LocationDetail {
  final String name;
  final String address;
  final String country;
  final String zipCode;
  final String image;
  final Location location;
  final ContactInformation contactInformation;

  LocationDetail({
    @required this.name,
    @required this.address,
    @required this.country,
    @required this.zipCode,
    this.image,
    @required this.location,
    @required this.contactInformation,
  })  : assert(name != null),
        assert(address != null),
        assert(country != null),
        assert(zipCode != null),
        assert(location != null),
        assert(contactInformation != null);
}

class KeyHighlight {
  final String firstName;
  final String lastName;
  final String topic;
  final String place;
  final DateTime startTime;
  final DateTime endTime;
  final String avatar;

  KeyHighlight({
    @required this.firstName,
    @required this.lastName,
    @required this.topic,
    @required this.place,
    @required this.startTime,
    @required this.endTime,
    this.avatar,
  })  : assert(firstName != null),
        assert(lastName != null),
        assert(topic != null),
        assert(place != null),
        assert(startTime != null),
        assert(endTime != null);
}

class Event {
  final String id;
  final String title;
  final String description;
  final String shortDescription;
  final LocationDetail locationDetails;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final int days;
  final int likes;
  final List<KeyHighlight> keyHighlights;
  final List<Speaker> speaker;
  final String image;
  final List<String> topics;
  final Category category;
  final Organizer organizers;

  Event({
    @required this.id,
    @required this.title,
    @required this.description,
    this.shortDescription = '',
    @required this.locationDetails,
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    this.days = 1,
    this.likes = 0,
    @required this.keyHighlights,
    @required this.speaker,
    this.image,
    @required this.topics,
    @required this.category,
    @required this.organizers,
  })  : assert(id != null),
        assert(title != null),
        assert(description != null),
        assert(shortDescription != null),
        assert(locationDetails != null),
        assert(date != null),
        assert(startTime != null),
        assert(endTime != null),
        assert(keyHighlights != null),
        assert(speaker != null),
        assert(topics != null),
        assert(category != null),
        assert(organizers != null);
}

class EventDetailsArguments {
  final String eventId;

  EventDetailsArguments({@required this.eventId}) : assert(eventId != null);
}

final List<Event> allEvents = [
  new Event(
    id: 'aaaa1234567895454979',
    title: 'VoltEdge',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Blandit turpis cursus in hac habitasse platea dictumst quisque sagittis. Faucibus in ornare quam viverra. Rhoncus dolor purus non enim.',
    topics: ['Animate using flutter', 'How to GraphQL'],
    category: Category.Events,
    organizers: new Organizer(
      firstName: 'Rahul',
      lastName: 'N',
      contactInformation: new ContactInformation(
        email: 'r.n@g.com',
        mobile: [123456789],
        phone: [001234578],
      ),
    ),
    keyHighlights: [
      new KeyHighlight(
        firstName: 'Rahul',
        lastName: 'N',
        topic: 'Animate using Flutter',
        place: 'Room 101',
        startTime: DateTime(2020, 4, 20, 11, 30),
        endTime: DateTime(2020, 4, 20, 12, 0),
      ),
      new KeyHighlight(
        firstName: 'Amit',
        lastName: 'S',
        topic: 'AI',
        place: 'Room 101',
        startTime: DateTime(2020, 4, 20, 11, 0),
        endTime: DateTime(2020, 4, 20, 11, 30),
      ),
    ],
    locationDetails: new LocationDetail(
      name: 'Sheraton',
      address: 'Sheraton Whitefield',
      country: 'India',
      zipCode: '560048',
      location:
          new Location(locationType: LocationType.Point, coordinates: [0, 0]),
      contactInformation: new ContactInformation(email: 'someone@g.com'),
    ),
    date: new DateTime(2020, 4, 20),
    startTime: new DateTime(2020, 4, 20, 8, 30),
    endTime: new DateTime(2020, 4, 20, 16, 30),
    image: 'assets/images/events/event_02.jpg',
    speaker: [
      new Speaker(
        id: 'aacaseq12345489',
        firstName: 'Rahul',
        lastName: 'N',
        email: 'r.n@g.com',
        topics: ['Flutter 101', 'Graph 101'],
        hobbies: ['Cricket'],
        events: [],
      ),
      new Speaker(
        id: 'aacaseq12345489',
        firstName: 'Amit',
        lastName: 'S',
        email: 'a.s@g.com',
        topics: ['Web 4.0', 'A.I'],
        hobbies: ['Marathon Runner'],
        events: [],
      ),
    ],
  ),
  new Event(
    id: 'bbbb1234567895454789',
    title: 'VoltEdge 3 2 1',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Blandit turpis cursus in hac habitasse platea dictumst quisque sagittis. Faucibus in ornare quam viverra. Rhoncus dolor purus non enim.',
    topics: ['Animate using flutter', 'How to GraphQL'],
    category: Category.Events,
    organizers: new Organizer(
      firstName: 'Rahul',
      lastName: 'N',
      contactInformation: new ContactInformation(
        email: 'r.n@g.com',
        mobile: [123456789],
        phone: [001234578],
      ),
    ),
    image: 'assets/images/events/event_03.jpg',
    keyHighlights: [
      new KeyHighlight(
        firstName: 'Rahul',
        lastName: 'N',
        topic: 'Animate using Flutter',
        place: 'Room 101',
        startTime: DateTime(2020, 4, 20, 11, 30),
        endTime: DateTime(2020, 4, 20, 12, 0),
      ),
      new KeyHighlight(
        firstName: 'Amit',
        lastName: 'S',
        topic: 'AI',
        place: 'Room 101',
        startTime: DateTime(2020, 4, 20, 11, 0),
        endTime: DateTime(2020, 4, 20, 11, 30),
      ),
    ],
    locationDetails: new LocationDetail(
      name: 'Sheraton',
      address: 'Sheraton Whitefield',
      country: 'India',
      zipCode: '560048',
      location:
          new Location(locationType: LocationType.Point, coordinates: [0, 0]),
      contactInformation: new ContactInformation(email: 'someone@g.com'),
    ),
    date: new DateTime(2020, 4, 20),
    startTime: new DateTime(2020, 4, 20, 8, 30),
    endTime: new DateTime(2020, 4, 20, 16, 30),
    speaker: [
      new Speaker(
        id: 'aacaseq12345489',
        firstName: 'Rahul',
        lastName: 'N',
        email: 'r.n@g.com',
        topics: ['Flutter 101', 'Graph 101'],
        hobbies: ['Cricket'],
        events: [],
      ),
      new Speaker(
        id: 'aacaseq12345489',
        firstName: 'Amit',
        lastName: 'S',
        email: 'a.s@g.com',
        topics: ['Web 4.0', 'A.I'],
        hobbies: ['Marathon Runner'],
        events: [],
      ),
    ],
  ),
];
