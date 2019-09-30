import 'dart:async';
import 'package:beflex_clean_architecture/src/domain/entities/user.dart';
import 'package:beflex_clean_architecture/src/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rxdart/rxdart.dart';

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
      User user = await usersRepository.getUser(params.uid);
      controller.add(GetUserUseCaseResponse(user));

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
  GetUserUseCaseParams(this.uid);
}

class GetUserUseCaseResponse {
  dynamic response;
  GetUserUseCaseResponse(this.response);
}
