import 'package:beflex_clean_architecture/src/domain/entities/account.dart';
import 'package:beflex_clean_architecture/src/domain/entities/user.dart';
import 'package:beflex_clean_architecture/src/domain/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class DataUsersRepository extends UsersRepository {

  List<User> users;
  // sigleton
  static DataUsersRepository _instance = DataUsersRepository._internal();
  DataUsersRepository._internal() {
    users = List<User>();
    //users.addAll([User('test-uid', 'John Smith', 18), User('test-uid2', 'John Doe', 22)]);
  }
  factory DataUsersRepository() => _instance;

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
  Future<bool> addUser(String name, double amount) async {
    Uuid _uuid = Uuid();
    var beforeCount = users.length;
    Account newAccount = Account(0, amount);
    List<Account> newAccountList = List<Account>();
    newAccountList.add(newAccount);
    users.add(User(_uuid.v4(),name, accounts:newAccountList ));

    if(beforeCount +1 == users.length){
      return true;
    }
    return false;

  }

  @override
  Future<int> getUserCount() async {
    
    return users.length;
  }
  
}