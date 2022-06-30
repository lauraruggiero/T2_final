import '../dao/event_dao.dart';
import '../model/event.dart';

class EventRepository {
  final eventDao = EventDao();

  Future getAllEvents() => eventDao.getAllEvents();

  Future getEventsForDay(DateTime day) => eventDao.getEventsForDay(day);

  Future insertEvent(Event event) => eventDao.createEvent(event);

  Future updateEvent(Event event) => eventDao.updateEvent(event);

  Future deleteEventById(int id) => eventDao.deleteEvent(id);

  //Future deleteAllEvents() => eventDao.deleteAllEvents();
}
