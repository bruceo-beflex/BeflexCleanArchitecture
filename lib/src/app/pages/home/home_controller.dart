import 'package:beflex_clean_architecture/src/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'home_presenter.dart';

class HomeController extends Controller {
  int _counter;
  User _user;
  int _userCount;
  List<User> _users;

  int get counter => _counter;
  int get userCount => _userCount;
  User get user => _user;
  List<User> get users => _users;

  final HomePresenter homePresenter;
  // Presenter should always be initialized this way
  HomeController(dynamic usersRepo)
      : _counter = 0,
      _userCount = 0,
        homePresenter = HomePresenter(usersRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
    homePresenter.addUserOnComplete = () {
      print("Add completed");
    };

    homePresenter.addUserOnNext = (bool result){
      print("Adding user : "+  result.toString());
    };

    homePresenter.addUserOnError = (e){
      print('Could not add user.');
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      _user = null;
      refreshUI();
    };


    homePresenter.getAllUsersOnNext = (result){
      print("get all user handler");
      getAllUsersResult(result);
    };

    

    homePresenter.getUserOnNext = (result) {
      if (result is int) {
        _userCount = result;
      } else {
        _user = user;
      }

      refreshUI(); // Refreshes the UI manually
    };

    
    homePresenter.getUserOnComplete = () {
      print('User retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    homePresenter.getUserOnError = (e) {
      print('Could not retrieve user.');
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      _user = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  getAllUsersResult(List<User> result) {
    _users = result;
    _userCount = _users.length;
    refreshUI();
  }

  void getUser() => homePresenter.getUser('test-uid');

  void getUserwithError() => homePresenter.getUser('test-uid231243');

  void addUser(String name, double amount) =>
      homePresenter.addUser(name, amount);

  void buttonPressed() {
    _counter++;
  }

  @override
  void dispose() {
    homePresenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }
}
