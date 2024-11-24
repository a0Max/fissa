import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_data_with_otp_model.dart';
import '../repositories/repositories_login_update.dart';

class CheckOtpUseCases {
  final LoginUpdateRepository repository;

  CheckOtpUseCases(this.repository);

  Future<Either<Failure, UserDataWithOtpModel>> call(
      {required String phone, required String otp}) async {
    return await repository.checkOtpRepository(phone: phone, otp: otp);
  }
}
