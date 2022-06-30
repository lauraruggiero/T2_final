import 'dart:async';
import '../database/database.dart';
import '../model/event.dart';

class EventDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createEvent(Event event) async {
    final db = await dbProvider.database;
    var result = db.insert(eventTABLE, event.toDatabaseJson());
    return result;
  }

  Future<List<Event>> getAllEvents() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(eventTABLE);

    List<Event> events = result.isNotEmpty
        ? result.map((item) => Event.fromDatabaseJson(item)).toList()
        : [];
    return events;
  }

  Future<List<Event>> getEventsForDay(DateTime day) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db
        .query(eventTABLE, where: 'date = ?', whereArgs: [day.toString()]);

    List<Event> events = result.isNotEmpty
        ? result.map((item) => Event.fromDatabaseJson(item)).toList()
        : [];
    return events;
  }

  Future<int> updateEvent(Event event) async {
    final db = await dbProvider.database;

    var result = await db.update(eventTABLE, event.toDatabaseJson(),
        where: "event_id = ?", whereArgs: [event.eventId]);

    return result;
  }

  Future<int> deleteEvent(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(eventTABLE, where: 'event_id = ?', whereArgs: [id]);
    return result;
  }
}
