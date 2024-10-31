import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fisaa/features/details_of_transports_goods/domain/entities/trip_details_model.dart';
import 'package:fisaa/features/intro/domain/entities/user_data_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../../domain/repositories/repositories_trip_of_puller.dart';
import '../data_sources/trip_of_puller_data_sources.dart';

class PullerRepositoryImpl implements RepositoriesTripOfPuller {
  final DataSourceRemotelyOfTripOfPuller remoteDataSource;

  final NetworkInfo networkInfo;

  PullerRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, TripDetailsModel>> sendTripRequestCreate(
      {required UserData userData,
      required FullLocationModel locationData}) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.sendTripRequestCreate(
            userData: userData, locationData: locationData);
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

  @override
  Future<Either<Failure, String>> getThePriceOrTrip(
      {required UserData userData,
      required FullLocationModel locationData}) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.getThePriceOrTrip(
            userData: userData, locationData: locationData);
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
