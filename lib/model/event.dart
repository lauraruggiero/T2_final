import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Event {
  String title;
  int eventId;
  String userId;
  DateTime date;
  //TimeOfDay time;

  Event({
    @required this.title,
    this.eventId,
    this.userId,
    this.date,
    /*this.time*/
  });

  @override
  String toString() => title;

  factory Event.fromDatabaseJson(Map<String, dynamic> json) => Event(
        eventId: json['event_id'],
        userId: json['user_id'],
        title: json['title'],
        date: DateTime.parse(json['date']),
        //time: json['time'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "event_id": eventId,
        "user_id": userId,
        "title": title,
        "date": date.toString(),
        //"time": time,
      };
}
