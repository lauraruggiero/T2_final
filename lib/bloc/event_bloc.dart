import '../model/event.dart';
import '../repository/event_repository.dart';

import 'dart:async';

class EventBloc {
  final _eventRepository = EventRepository();
  final _eventController = StreamController<List<Event>>.broadcast();

  get events => _eventController.stream;

  EventBloc() {
    getEventsForDay(DateTime.utc(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 0, 0));
  }

  getEventsForDay(DateTime day) async {
    _eventController.sink.add(await _eventRepository.getEventsForDay(day));
  }

  addEvent(Event event, DateTime day) async {
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
