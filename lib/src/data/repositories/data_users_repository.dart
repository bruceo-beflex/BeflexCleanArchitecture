
import 'dart:async';

import 'package:beflex_clean_architecture/src/domain/entities/user.dart';
import 'package:beflex_clean_architecture/src/domain/repositories/user_repository.dart';

class DataUsersRepository extends UsersRepository {

  List<User> users;
  // sigleton
  static DataUsersRepository _instance = DataUsersRepository._internal();
  DataUsersRepository._internal() {
    users = List<User>();
    //users.addAll([User('test-uid', 'John Smith', 18), User('test-uid2', 'John Doe', 22)]);
  }

  factory DataUsersRepository() => _instance;

  StreamController<int> countController = new StreamController<int>();

  @override
  void dispose(){
    countController.close();
  }

  @override
  Future<List<User>> getAllUsers() async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data
    return users;
  }

  @override
  Future<User> getUser(String uid) async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data

    return users.firstWhere((user) => user.uid == uid);
  }


  @override
  Future<bool> addUser(User user) async {
    int beforeCount = users.length;
    users.add(user);

    countController.sink.add(users.length);


    if(beforeCount +1 == users.length){
      return true;
    }
    return false;

  }

  @override
  Future<int> getUserCount() async {
    
    return users.length;
  }

  @override
  Future<Stream<int>> userCount() async {
    return countController.stream;
  }
  
}