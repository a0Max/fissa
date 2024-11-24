import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../repositories/repositories_login_update.dart';

class UpdateUserDataUseCases {
  final LoginUpdateRepository repository;

  UpdateUserDataUseCases(this.repository);

  Future<Either<Failure, UserData>> call(
      {required String name, required String email, File? image}) async {
    return await repository.updateUserDataRepository(
        email: email, name: name, image: image);
  }
}
