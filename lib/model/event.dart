import 'package:flutter/foundation.dart';

class Event {
  late String title;
  int? eventId;
  int? userId;

  Event({required this.title, this.eventId, this.userId});

  // @override
  // bool operator ==(Object other) => other is Event && title == other.title;

  // @override
  // int get hashCode => super.hashCode;

  @override
  String toString() => title;

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    userId = json['user_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    return data;
  }
}
