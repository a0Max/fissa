import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/predictions_model.dart';
import '../../domain/repositories/repositories_map.dart';
import '../data_sources/local_search_data_source.dart';
import '../data_sources/search_about_location_information.dart';

class MapRepositoryImpl implements MapRepository {
  final DataSourceRemotelyOfLocations remoteDataSource;
  final DataSourceRemotelyOfSearchLocal localDataSource;

  final NetworkInfo networkInfo;

  MapRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PredictionsModel>>> mapInformationDataRepository(
      {required String text,
      required LatLng latLng,
      required int radius}) async {
    if (await networkInfo.isConnected) {
      final res = await remoteDataSource.getMapDataRemotely(
          text: text, radius: radius, latLng: latLng);
      return Right(res);
    } else {
      return Left(CheckYourNetwork());
    }
  }

  @override
  Future<List<String>> getLocalTextSearch() async {
    List<String>? x = await localDataSource.getLocalTextSearch();
    return x ?? [];
  }

  @override
  Future<void> saveTextLocal({required String text}) async {
    print('@@@@@');
    await localDataSource.saveTextLocal(text: text);
  }
}
