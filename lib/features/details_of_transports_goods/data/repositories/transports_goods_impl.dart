import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fisaa/features/details_of_transports_goods/domain/entities/trip_details_model.dart';
import 'package:fisaa/features/intro/domain/entities/user_data_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../../domain/repositories/repositories_trip_of_transports_goods.dart';
import '../data_sources/trip_of_transports_goods_data_sources.dart';

class TransportsGoodsRepositoryImpl
    implements RepositoriesTripOfTransportsGoods {
  final DataSourceRemotelyOfTripOfTransportsGoods remoteDataSource;

  final NetworkInfo networkInfo;

  TransportsGoodsRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, TripDetailsModel>> sendTripRequestCreate(
      {required UserData userData,
      required FullLocationModel locationData,
      // required String startAddress,
      required String receiverName,
      required String receiverPhone,
      required String weight,
      required String objectType,
      required int workersNeeded}) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.sendTripRequestCreate(
            userData: userData,
            locationData: locationData,
            // location: location,
            receiverName: receiverName,
            receiverPhone: receiverPhone,
            // endAddress: endAddress,
            weight: weight,
            objectType: objectType,
            workersNeeded: workersNeeded);
        return Right(res);
      } on DioException catch (e, s) {
        print('error:$e');
        if (e is MessageException) {
          return Left(ServerFailure(message: "${e.message}"));
        }
        return Left(LoginFailure());
      } catch (e, s) {
        if (e is MessageException) {
          return Left(ServerFailure(message: e.message));
        }
        if (json.decode(e.toString())['message'] != null) {
          return Left(ServerFailure(message: e.toString()));
        }

        return Left(SendDataFailure());
      }
    } else {
      return Left(CheckYourNetwork());
    }
  }
}
