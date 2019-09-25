import 'account.dart';

class User {
  final String uid;
  final String name;
  List<Account> accounts;
  User(this.uid, this.name, {this.accounts});

  @override
  String toString() => '$name, $uid';
}