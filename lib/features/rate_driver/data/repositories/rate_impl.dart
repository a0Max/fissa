import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fisaa/features/details_of_transports_goods/domain/entities/trip_details_model.dart';
import 'package:fisaa/features/intro/domain/entities/user_data_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../../domain/repositories/repositories_rate_trip.dart';
import '../data_sources/rate_trip_data_sources.dart';

class RateRepositoryImpl implements RepositoriesRateTrip {
  final DataSourceRemotelyOfRateTrip remoteDataSource;

  final NetworkInfo networkInfo;

  RateRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, bool>> rateTrip({required int tripId}) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.rateTheTrip(tripId: tripId);
        print('res:$res');
        return Right(true);
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
