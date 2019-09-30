import 'dart:async';

import 'package:beflex_clean_architecture/src/domain/entities/user.dart';
import 'package:beflex_clean_architecture/src/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rxdart/rxdart.dart';

class GetAllUsersUseCase
    extends UseCase<GetAllUsersUseCaseResponse, GetAllUsersUseCaseParams> {
  final UsersRepository usersRepository;
  GetAllUsersUseCase(this.usersRepository);

  @override
  Future<Observable<GetAllUsersUseCaseResponse>> buildUseCaseObservable(
      GetAllUsersUseCaseParams params) async {
    final StreamController<GetAllUsersUseCaseResponse> controller =
        StreamController();

    try {
      var users = await usersRepository.getAllUsers();
      controller.add(GetAllUsersUseCaseResponse(users));
    } catch (e) {}

    controller.close();
    return Observable(controller.stream);
  }
}

class GetAllUsersUseCaseResponse {
  List<User> users;
  GetAllUsersUseCaseResponse(this.users);
}

class GetAllUsersUseCaseParams {}

