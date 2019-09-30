import 'package:beflex_clean_architecture/src/domain/entities/user.dart';

abstract class UsersRepository {
  Future<User> getUser(String uid);
  Future<List<User>> getAllUsers();
  Future<int> getUserCount();
  Future<bool> addUser(User user);
}