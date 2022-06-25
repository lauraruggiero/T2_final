import 'dart:async';
import '../database/user_database.dart';
import '../model/user.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createUser(User user) async {
    final db = await dbProvider.database;
    var result = db.insert(userTABLE, user.toDatabaseJson());
    return result;
  }

  Future<List<User>> getUsers({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db.query(userTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
      }
    } else {
      result = await db.query(userTABLE, columns: columns);
    }

    List<User> users = result.isNotEmpty
        ? result.map((item) => User.fromDatabaseJson(item)).toList()
        : [];
    return users;
  }

  Future<int> updateUser(User user) async {
    final db = await dbProvider.database;

    var result = await db.update(userTABLE, user.toDatabaseJson(),
        where: "email = ?", whereArgs: [user.email]);

    return result;
  }

  Future<int> deleteUser(String email) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(userTABLE, where: 'email = ?', whereArgs: [email]);
    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllUsers() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      userTABLE,
    );

    return result;
  }
}
