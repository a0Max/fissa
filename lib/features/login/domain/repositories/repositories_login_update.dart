import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../entities/user_data_with_otp_model.dart';

abstract class LoginUpdateRepository {
  Future<Either<Failure, UserDataWithOtpModel>> loginRepository(
      {required String phone});
  Future<Either<Failure, UserDataWithOtpModel>> addRequiredDataRepository(
      {required String name, required String? email});
  Future<Either<Failure, UserDataWithOtpModel>> checkOtpRepository(
      {required String phone, required String otp});
  Future<Either<Failure, UserData>> updateUserDataRepository(
      {required String name, required String email, File? image});
}
