import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_data_with_otp_model.dart';
import '../repositories/repositories_login_update.dart';

class AddRequiredDataUseCases {
  final LoginUpdateRepository repository;

  AddRequiredDataUseCases(this.repository);

  Future<Either<Failure, UserDataWithOtpModel>> call(
      {required String name, required String? email}) async {
    return await repository.addRequiredDataRepository(name: name, email: email);
  }
}
