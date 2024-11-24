import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_data_with_otp_model.dart';
import '../repositories/repositories_login_update.dart';

class LogOutUseCases {
  final LoginUpdateRepository repository;

  LogOutUseCases(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.logOutRepository();
  }
}
