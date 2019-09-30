import 'package:beflex_clean_architecture/src/domain/usecases/add_user_usecase.dart';
import 'package:beflex_clean_architecture/src/domain/usecases/get_all_users_usecase.dart';
import 'package:beflex_clean_architecture/src/domain/usecases/get_user_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePresenter extends Presenter {
  Function getUserOnNext;
  Function getUserOnComplete;
  Function getUserOnError;

  Function addUserOnNext;
  Function addUserOnComplete;
  Function addUserOnError;

  Function getAllUsersOnNext;

  final GetUserUseCase getUserUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final AddUserUseCase addUserUseCase;

  HomePresenter(usersRepo)
      : getUserUseCase = GetUserUseCase(usersRepo),
        addUserUseCase = AddUserUseCase(usersRepo),
        getAllUsersUseCase = GetAllUsersUseCase(usersRepo);

  void getUser(String uid) {
    // execute getUseruserCase
    getUserUseCase.execute(
        _GetUserUseCaseObserver(this), GetUserUseCaseParams(uid));
  }

  void getAllUsers() {
    getAllUsersUseCase.execute(
        _GetAllUsersUseCaseObserver(this), GetAllUsersUseCaseParams());
  }

  void addUser(String name, double amount) {
    addUserUseCase.execute(
        _AddUserUseCaseObserver(this), AddUserUseCaseParams(name, amount));
  }

  @override
  void dispose() {
    getUserUseCase.dispose();
    addUserUseCase.dispose();
  }
}

class _AddUserUseCaseObserver extends Observer<AddUserUseCaseResponse> {
  final HomePresenter presenter;
  _AddUserUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    assert(presenter.addUserOnComplete != null);
    presenter.addUserOnComplete();
    presenter.getAllUsers();
  }

  @override
  void onError(e) {
    assert(presenter.addUserOnError != null);
    presenter.addUserOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.addUserOnNext != null);
    presenter.addUserOnNext(response.isSucceed);
  }
}

class _GetAllUsersUseCaseObserver extends Observer<GetAllUsersUseCaseResponse> {
  final HomePresenter presenter;
  _GetAllUsersUseCaseObserver(this.presenter);

  @override
  void onComplete() {
  }

  @override
  void onError(e) {
    // TODO: implement onError
  }

  @override
  void onNext(GetAllUsersUseCaseResponse response) {
    print("getting all user : ${response.users.length}");
    assert(presenter.getAllUsersOnNext != null);
    presenter.getAllUsersOnNext(response.users);
  }
}

class _GetUserUseCaseObserver extends Observer<GetUserUseCaseResponse> {
  final HomePresenter presenter;
  _GetUserUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    assert(presenter.getUserOnComplete != null);
    presenter.getUserOnComplete();
    
  }

  @override
  void onError(e) {
    assert(presenter.getUserOnError != null);
    presenter.getUserOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getUserOnNext != null);
    presenter.getUserOnNext(response);
  }
}

abstract class Abstrction{

}

class Imple{
  Abstrction abs;

}
