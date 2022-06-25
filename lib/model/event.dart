import 'package:flutter/foundation.dart';

class Event {
  String title;
  int eventId;
  String userId;
  DateTime date;

  Event({@required this.title, this.eventId, this.userId, this.date});

  @override
  String toString() => title;

  // Event.fromDatabaseJson(Map<String, dynamic> json) {
  //   eventId = json['event_id'];
  //   userId = json['user_id'];
  //   title = json['title'];
  // }

  factory Event.fromDatabaseJson(Map<String, dynamic> json) => Event(
        eventId: json['event_id'],
        userId: json['user_id'],
        title: json['title'],
        date: DateTime.parse(json['date']),
      );

  Map<String, dynamic> toDatabaseJson() => {
        "event_id": eventId,
        "user_id": userId,
        "title": title,
        "date": date.toString(),
      };
}
