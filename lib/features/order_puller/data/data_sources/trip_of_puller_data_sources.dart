import '../../../../core/apis_connections/api_connection.dart';
import '../../../../core/connection.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';

abstract class DataSourceRemotelyOfTripOfPuller {
  Future<TripDetailsModel> sendTripRequestCreate({
    required UserData userData,
    required FullLocationModel locationData,
  });
  Future<String> getThePriceOrTrip(
      {required UserData userData, required FullLocationModel locationData});
}

class DataSourceRemotelyOfTripOfPullerImpl
    implements DataSourceRemotelyOfTripOfPuller {
  final MainApiConnection dio;

  DataSourceRemotelyOfTripOfPullerImpl({required this.dio});

  @override
  Future<TripDetailsModel> sendTripRequestCreate(
      {required UserData userData,
      required FullLocationModel locationData}) async {
    final response = await dio.post(
        url: '${Connection.baseURL}${dio.createTripsEndPoint}',
        queryParameters: {
          'passenger_id': userData.id,
          'type_id': 1,
          'from': locationData.startAddress,
          'from_lat': locationData.startLocation?.lat ?? 0, //30.0444, //
          'from_lng': locationData.startLocation?.lng ?? 0, //31.2357, //
          'to': locationData.endAddress,
          'to_lat': locationData.endLocation?.lat ?? 0, //29.9765, //
          'to_lng': locationData.endLocation?.lng ?? 0, //31.1313, //
          'is_cash': 1,
          'payment_by': 'sender'
        });
    if (dio.validResponse(response)) {
      return TripDetailsModel.fromJson(response.data['data']['trip']);
    } else {
      throw response.data['msg'];
    }
  }

  @override
  Future<String> getThePriceOrTrip(
      {required UserData userData,
      required FullLocationModel locationData}) async {
    final response = await dio.post(
        url: '${Connection.baseURL}${dio.getThePriceOfTripTripsEndPoint}',
        queryParameters: {
          'passenger_id': userData.id,
          'type_id': 1,
          'from': locationData.startAddress,
          'from_lat': locationData.startLocation?.lat ?? 0, //30.0444, //
          'from_lng': locationData.startLocation?.lng ?? 0, //31.2357, //
          'to': locationData.endAddress,
          'to_lat': locationData.endLocation?.lat ?? 0, //29.9765, //
          'to_lng': locationData.endLocation?.lng ?? 0, //31.1313, //
          'is_cash': 1,
          'sender_name': "${userData.name}",
          'sender_phone': userData.phone,
          'payment_by': 'sender'
        });
    if (dio.validResponse(response)) {
      return response.data['total_price'].toString();
    } else {
      throw response.data['msg'];
    }
  }
}
