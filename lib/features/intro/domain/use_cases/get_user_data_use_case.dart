import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_data_model.dart';
import '../repositories/repositories_intro.dart';

class GetUserDataUseCases {
  final IntroRepository repository;

  GetUserDataUseCases(this.repository);

  Future<Either<Failure, UserData>> call() async {
    return await repository.getUserDataRepository();
  }
}
