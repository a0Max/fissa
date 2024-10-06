import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/predictions_model.dart';
import '../../domain/repositories/repositories_map.dart';
import '../data_sources/search_about_location_information.dart';

class LessonRepositoryImpl implements MapRepository {
  final DataSourceRemotelyOfLocations remoteDataSource;

  final NetworkInfo networkInfo;

  LessonRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<PredictionsModel>>> mapInformationDataRepository(
      {required String text,
      required LatLng latLng,
      required int radius}) async {
    if (await networkInfo.isConnected) {
      // try {
      final res = await remoteDataSource.getMapDataRemotely(
          text: text, radius: radius, latLng: latLng);
      return Right(res);
      // } catch (e, s) {
      //   print('error:$e');
      //   log('error:$e');
      //   return Left(LoginFailure());
      // }
    } else {
      return Left(CheckYourNetwork());
    }
  }
}
