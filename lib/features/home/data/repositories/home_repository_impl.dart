import 'package:dartz/dartz.dart';
import 'package:fisaa/features/home/domain/entities/home_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/repositories_home.dart';
import '../data_sources/home_data_sources.dart';

class HomeRepositoryImpl implements HomeRepository {
  final DataSourceRemotelyOfHome remoteDataSource;

  final NetworkInfo networkInfo;

  HomeRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, HomeModel>> getHomeDataRepository() async {
    if (await networkInfo.isConnected) {
      final res = await remoteDataSource.getHomeDataRemotely();
      return Right(res);
    } else {
      return Left(CheckYourNetwork());
    }
  }
}
