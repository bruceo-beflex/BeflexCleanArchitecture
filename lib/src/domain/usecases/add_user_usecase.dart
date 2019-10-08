

import 'dart:async';
import 'package:beflex_clean_architecture/src/domain/entities/account.dart';
import 'package:beflex_clean_architecture/src/domain/entities/user.dart';
import 'package:beflex_clean_architecture/src/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class AddUserUseCase extends UseCase<AddUserUseCaseResponse, AddUserUseCaseParams>{
  final UsersRepository usersRepository;

  AddUserUseCase(this.usersRepository);
  
  @override
  Future<Observable<AddUserUseCaseResponse>> buildUseCaseObservable(AddUserUseCaseParams params) async {
    final StreamController<AddUserUseCaseResponse> controller = StreamController();
    try {

      Uuid uuidMaker = Uuid();
      List<Account> newAccountList = List<Account>();
      newAccountList.add(Account(0, params.deposit));

      User newUser = User(uuidMaker.v4(), params.name,accounts: newAccountList);

      bool isSucceed = await usersRepository.addUser(newUser);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(AddUserUseCaseResponse(isSucceed));
      controller.close();
    } catch (e) {
      logger.severe('GetUserUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

class AddUserUseCaseResponse {
  bool isSucceed;
  AddUserUseCaseResponse(this.isSucceed);
}

class AddUserUseCaseParams {
  String name;
  double deposit;
  AddUserUseCaseParams(this.name, this.deposit);
}