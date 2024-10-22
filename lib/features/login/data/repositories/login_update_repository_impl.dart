import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fisaa/features/home/domain/entities/home_model.dart';
import 'package:fisaa/features/login/domain/entities/user_data_with_otp_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/repositories_login_update.dart';
import '../data_sources/login_update_data_sources.dart';

class LoginUpdateRepositoryImpl implements LoginUpdateRepository {
  final DataSourceRemotelyOfLoginUpdateData remoteDataSource;

  final NetworkInfo networkInfo;

  LoginUpdateRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserDataWithOtpModel>> addRequiredDataRepository(
      {required String name, required String? email}) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.addRequiredDataRepository(
            name: name, email: email);
        print('res:$res');
        return Right(res);
      } on DioException catch (e, s) {
        print('error:0$e');
        if (e is MessageException) {
          return Left(ServerFailure(message: "${e.message}"));
        }
        return Left(LoginFailure());
      } catch (e, s) {
        if (e is MessageException) {
          return Left(ServerFailure(message: e.message));
        }
        return Left(SendDataFailure());
      }
    } else {
      return Left(CheckYourNetwork());
    }
  }

  @override
  Future<Either<Failure, UserDataWithOtpModel>> checkOtpRepository(
      {required String phone, required String otp}) async {
    if (await networkInfo.isConnected) {
      try {
        final res =
            await remoteDataSource.checkOtpRepository(phone: phone, otp: otp);
        print('res:$res');
        return Right(res);
      } on DioException catch (e, s) {
        print('error:0$e');
        if (e is MessageException) {
          return Left(ServerFailure(message: "${e.message}"));
        }
        return Left(LoginFailure());
      } catch (e, s) {
        if (e is MessageException) {
          print('error:${e.message}');

          return Left(ServerFailure(message: e.message));
        }
        return Left(SendDataFailure());
      }
    } else {
      return Left(CheckYourNetwork());
    }
  }

  @override
  Future<Either<Failure, UserDataWithOtpModel>> loginRepository(
      {required String phone}) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.loginRepository(phone: phone);
        print('res:$res');
        return Right(res);
      } on DioException catch (e, s) {
        print('error:0$e');
        if (e is MessageException) {
          return Left(ServerFailure(message: "${e.message}"));
        }
        return Left(LoginFailure());
      } catch (e, s) {
        print('error:$e');
        if (e is MessageException) {
          print('error:${e.message}');

          return Left(ServerFailure(message: e.message));
        }
        return Left(SendDataFailure());
      }
    } else {
      return Left(CheckYourNetwork());
    }
  }
}
