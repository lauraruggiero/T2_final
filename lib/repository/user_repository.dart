import '../dao/user_dao.dart';
import '../model/user.dart';

class UserRepository {
  final userObj = UserDao();

  Future getAllUsers({String query}) => userObj.getUsers(query: query);

  Future insertUsers(User user) => userObj.createUser(user);

  Future updateUser(User user) => userObj.updateUser(user);

  Future deleteUserById(String email) => userObj.deleteUser(email);

  Future deleteAllUsers() => userObj.deleteAllUsers();
}
