import 'dart:async';

import 'package:beflex_clean_architecture/src/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rxdart/rxdart.dart';

class GetUserCountUsecase extends UseCase<Stream<int>,void>{

  final UsersRepository usersRepository;
  GetUserCountUsecase(this.usersRepository);

  @override
  Future<Observable<Stream<int>>> buildUseCaseObservable(void params) async {
    
    final StreamController<Stream<int>> controller = StreamController<Stream<int>>();

    try{
      controller.add(await usersRepository.userCount());

      controller.close();

    }catch(e){

    }

    

    return Observable(controller.stream);
  }


}


class GetUserCountUseCaseParams {
  final int uid;
  GetUserCountUseCaseParams(this.uid);
}

class GetUserCountUseCaseResponse {
  dynamic response;
  GetUserCountUseCaseResponse(this.response);
}

