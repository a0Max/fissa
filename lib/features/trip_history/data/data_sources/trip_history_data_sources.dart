import '../../../../core/apis_connections/api_connection.dart';
import '../../../../core/connection.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';

abstract class DataSourceRemotelyOfTripHistory {
  Future<List<TripDetailsModel>> getTripHistoryRequestCreate();
}

class DataSourceRemotelyOfTripHistoryImpl
    implements DataSourceRemotelyOfTripHistory {
  final MainApiConnection dio;

  DataSourceRemotelyOfTripHistoryImpl({required this.dio});

  @override
  Future<List<TripDetailsModel>> getTripHistoryRequestCreate() async {
    final response =
        await dio.get(url: '${Connection.baseURL}${dio.tripHistoryEndPoint}');
    if (dio.validResponse(response)) {
      final List<TripDetailsModel> l = [];
      response.data['data'].forEach((e) {
        l.add(TripDetailsModel.fromJson(e));
      });
      return l;
    } else {
      throw response.data['msg'];
    }
  }
}
