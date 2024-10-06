import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/apis_connections/api_connection.dart';
import '../../../../core/connection.dart';
import '../../../../core/main_map_informations.dart';
import '../../domain/entities/predictions_model.dart';

abstract class DataSourceRemotelyOfLocations {
  Future<List<PredictionsModel>> getMapDataRemotely(
      {required String text, required LatLng latLng, required int radius});
}

class DataSourceRemotelyOfLocationsImpl
    implements DataSourceRemotelyOfLocations {
  final MainApiConnection dio;

  DataSourceRemotelyOfLocationsImpl({required this.dio});

  @override
  Future<List<PredictionsModel>> getMapDataRemotely(
      {required String text,
      required LatLng latLng,
      required int radius}) async {
    final response = await dio.get(
        url: '${Connection.baseURLOfGoogle}${dio.locationInformationEndPoint}',
        queryParameters: {
          'input': text,
          'key': MainMapInformation.mapKey,
          'language': 'en',
          'location': '${latLng.latitude},${latLng.longitude}',
          'radius': radius,
        });
    if (dio.validResponse(response)) {
      final List<PredictionsModel> l = [];
      response.data['results'].forEach((e) {
        l.add(PredictionsModel.fromJson(e));
      });
      return l;
    } else {
      throw response.data['msg'];
    }
  }
}
