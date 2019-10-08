import 'package:beflex_clean_architecture/src/domain/entities/user.dart';
import 'package:flutter/material.dart';

abstract class UsersRepository {
  Future<User> getUser(String uid);
  Future<List<User>> getAllUsers();
  Future<int> getUserCount();
  Future<bool> addUser(User user);
  Future<Stream<int>> userCount();

  
}