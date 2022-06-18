import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'model/event.dart';
import 'model/user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Users ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "email TEXT,"
          "password TEXT"
          ")");
      await db.execute("CREATE TABLE Events ("
          "event_id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "user_id TEXT,"
          "title TEXT"
          ")");
    });
  }

  newUser(User newUser) async {
    final db = await database;
    var res = await db.insert("Users", newUser.toJson());
    return res;
  }

  newEvent(Event newEvent) async {
    final db = await database;
    var res = await db.insert("Events", newEvent.toJson());
    return res;
  }

  getUser(int id) async {
    final db = await database;
    var res = await db.query("Users", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? User.fromJson(res.first) : Null;
  }

  getEvent(int id) async {
    final db = await database;
    var res = await db.query("Events", where: "event_id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Event.fromJson(res.first) : Null;
  }

  Future<List<Event>> getEventsForUser(int userId) async {
    final db = await database;
    var res =
        await db.query("Events", where: "user_id = ?", whereArgs: [userId]);
    List<Event> list =
        res.isNotEmpty ? res.map((c) => Event.fromJson(c)).toList() : [];
    return list;
  }
}
