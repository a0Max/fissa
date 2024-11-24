import 'package:dartz/dartz.dart';
import 'package:fisaa/core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/entities/get_stuff_types_model.dart';
import '../../domain/entities/main_app_required.dart';
import '../../domain/entities/user_data_model.dart';
import '../../domain/repositories/repositories_intro.dart';
import '../data_sources/intro_data_sources.dart';

class IntroRepositoryImpl implements IntroRepository {
  final DataSourceRemotelyOfIntro remoteDataSource;

  final NetworkInfo networkInfo;

  IntroRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, MainAppRequiredModel>>
      getStuffTypesDataRepository() async {
    if (await networkInfo.isConnected) {
      final res = await remoteDataSource.getStuffTypesDataRepository();
      return Right(res);
    } else {
      return Left(CheckYourNetwork());
    }
  }

  @override
  Future<Either<Failure, UserData>> getUserDataRepository() async {
    if (await networkInfo.isConnected) {
      final res = await remoteDataSource.getUserDataRepository();
      return Right(res);
    } else {
      return Left(CheckYourNetwork());
    }
  }
}
