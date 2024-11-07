import '../../../../core/apis_connections/api_connection.dart';
import '../../../../core/connection.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';

abstract class ReorderTripDataSources {
  Future<TripDetailsModel> sendTripRequestCreate(
      {required TripDetailsModel currentTrip});
}

class DataSourceReorderTripImpl implements ReorderTripDataSources {
  final MainApiConnection dio;

  DataSourceReorderTripImpl({required this.dio});

  @override
  Future<TripDetailsModel> sendTripRequestCreate(
      {required TripDetailsModel currentTrip}) async {
    final response = await dio.post(
        url: '${Connection.baseURL}${dio.createTripsEndPoint}',
        queryParameters: {
          'passenger_id': currentTrip.passenger?.id,
          'type_id': currentTrip.typeId,
          'from': currentTrip.from,
          'from_lat': currentTrip.fromLat ?? 0, //30.0444, //
          'from_lng': currentTrip.fromLng ?? 0, //31.2357, //
          'to': currentTrip.to,
          'to_lat': currentTrip.toLat ?? 0, //29.9765, //
          'to_lng': currentTrip.toLng ?? 0, //31.1313, //
          'is_cash': 1,
          'object_type': currentTrip.stuffType?.id,
          'weight': currentTrip.weight?.id,
          'sender_name': "${currentTrip.passenger?.name}",
          'sender_phone': currentTrip.passenger?.phone,
          'receiver_name': currentTrip.receiverName,
          'receiver_phone': currentTrip.receiverPhone,
          'workers_needed': currentTrip.worker?.id,
          'payment_by': 'sender'
        });
    if (dio.validResponse(response)) {
      return TripDetailsModel.fromJson(response.data['data']['trip']);
    } else {
      throw response.data['msg'];
    }
  }
}
