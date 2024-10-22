import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_data_with_otp_model.dart';
import '../repositories/repositories_login_update.dart';

class LoginUseCases {
  final LoginUpdateRepository repository;

  LoginUseCases(this.repository);

  Future<Either<Failure, UserDataWithOtpModel>> call(
      {required String phone}) async {
    return await repository.loginRepository(phone: phone);
  }
}
