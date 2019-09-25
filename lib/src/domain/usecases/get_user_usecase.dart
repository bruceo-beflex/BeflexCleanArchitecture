import 'dart:async';
import 'package:beflex_clean_architecture/src/domain/entities/user.dart';
import 'package:beflex_clean_architecture/src/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rxdart/rxdart.dart';

enum GetUserUseCaseParamsEnums { getUser, getAllUsers, getUserCount }

class GetUserUseCase
    extends UseCase<GetUserUseCaseResponse, GetUserUseCaseParams> {
  final UsersRepository usersRepository;
  GetUserUseCase(this.usersRepository);

  @override
  Future<Observable<GetUserUseCaseResponse>> buildUseCaseObservable(
      GetUserUseCaseParams params) async {
    final StreamController<GetUserUseCaseResponse> controller =
        StreamController();

    try {
      switch (params.getUserUseCaseParamEnum) {
        case GetUserUseCaseParamsEnums.getUser:
          User user = await usersRepository.getUser(params.uid);
          controller.add(GetUserUseCaseResponse(user));

          break;
        case GetUserUseCaseParamsEnums.getAllUsers:
          List<User> users = await usersRepository.getAllUsers();
          controller.add(GetUserUseCaseResponse(users));
          break;
        case GetUserUseCaseParamsEnums.getUserCount:
          int count = await usersRepository.getUserCount();
          controller.add(GetUserUseCaseResponse(count));
          break;
      }
      
      logger.finest('GetUserUseCase successful.');
      controller.close();

      // get user

    } catch (e) {
      logger.severe('GetUserUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

class GetUserUseCaseParams {
  final String uid;
  final GetUserUseCaseParamsEnums getUserUseCaseParamEnum;
  GetUserUseCaseParams(this.getUserUseCaseParamEnum, {this.uid});
}

class GetUserUseCaseResponse {
  dynamic input;
  GetUserUseCaseResponse(this.input);
}
