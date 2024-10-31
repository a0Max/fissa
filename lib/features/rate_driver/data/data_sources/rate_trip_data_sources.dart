import '../../../../core/apis_connections/api_connection.dart';
import '../../../../core/connection.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';

abstract class DataSourceRemotelyOfRateTrip {
  Future<bool> rateTheTrip({required int tripId});
}

class DataSourceRemotelyOfRateTripImpl implements DataSourceRemotelyOfRateTrip {
  final MainApiConnection dio;

  DataSourceRemotelyOfRateTripImpl({required this.dio});

  @override
  Future<bool> rateTheTrip({required int tripId}) async {
    final response = await dio.post(
      url: '${Connection.baseURL}${dio.rateTheTripsEndPoint(tripId: tripId)}',
    );
    if (dio.validResponse(response)) {
      return true;
    } else {
      throw response.data['msg'];
    }
  }
}
