import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fisaa/features/details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/repositories_trip_history.dart';
import '../data_sources/trip_history_data_sources.dart';

class TripHistoryRepositoryImpl implements RepositoriesTripHistory {
  final DataSourceRemotelyOfTripHistory remoteDataSource;

  final NetworkInfo networkInfo;

  TripHistoryRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<TripDetailsModel>>>
      getTripRequestHistory() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.getTripHistoryRequestCreate();
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
          return Left(ServerFailure(message: e.message));
        }
        return Left(SendDataFailure());
      }
    } else {
      return Left(CheckYourNetwork());
    }
  }
}
