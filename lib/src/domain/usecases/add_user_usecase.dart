

import 'dart:async';
import 'package:beflex_clean_architecture/src/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rxdart/rxdart.dart';

class AddUserUseCase extends UseCase<AddUserUseCaseResponse, AddUserUseCaseParams>{
  final UsersRepository usersRepository;

  AddUserUseCase(this.usersRepository);
  
  @override
  Future<Observable<AddUserUseCaseResponse>> buildUseCaseObservable(AddUserUseCaseParams params) async {
    final StreamController<AddUserUseCaseResponse> controller = StreamController();
    try {
      // get user
      bool isSucceed = await usersRepository.addUser(params.name, params.deposit);
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
  bool isSucceedtoAddUser;
  AddUserUseCaseResponse(this.isSucceedtoAddUser);

}

class AddUserUseCaseParams {
  String name;
  double deposit;
  AddUserUseCaseParams(this.name, this.deposit);
}