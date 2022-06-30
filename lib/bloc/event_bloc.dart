import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/event.dart';
import '../repository/event_repository.dart';

import 'dart:async';

class EventBloc {
  final _eventRepository = EventRepository();
  final _eventController = StreamController<List<Event>>.broadcast();
  Map<DateTime, List<Event>> _events = {};

  get events => _eventController.stream;

  EventBloc() {
    getEventsForDay(DateTime.utc(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0, 0)
        .toUtc());
  }

  List<Event> getEventsInCalendar(DateTime day) {
    return _events[day] ?? [];
  }

  getAllEvents() async {
    List<Event> events = await _eventRepository.getAllEvents();
    final Map<DateTime, List<Event>> eventsByDay = {};
    events.forEach((element) {
      eventsByDay.containsKey(element.date)
          ? eventsByDay[element.date].add(element)
          : eventsByDay[element.date] = [element];
    });
    _events = eventsByDay;
    return _events;
  }

  getEventsForDay(DateTime day) async {
    List<Event> events = await _eventRepository.getEventsForDay(day);
    _eventController.sink.add(events);
    _events[day] = events;
  }

  addEvent(
    Event event,
    DateTime day,
    /*TimeOfDay time*/
  ) async {
    await _eventRepository.insertEvent(event);
    getEventsForDay(day);
  }

  updateEvent(Event event, DateTime day) async {
    await _eventRepository.updateEvent(event);
    getEventsForDay(day);
  }

  deleteEventById(int id, DateTime day) async {
    _eventRepository.deleteEventById(id);
    getEventsForDay(day);
  }

  dispose() {
    _eventController.close();
  }
}
