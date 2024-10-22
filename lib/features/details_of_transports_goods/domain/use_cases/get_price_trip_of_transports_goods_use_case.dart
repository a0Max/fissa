import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../entities/trip_details_model.dart';
import '../repositories/repositories_trip_of_transports_goods.dart';

class GetPriceTripOfTransportsGoodsUseCases {
  final RepositoriesTripOfTransportsGoods repository;

  GetPriceTripOfTransportsGoodsUseCases(this.repository);

  Future<Either<Failure, String>> call(
      {required UserData userData,
      required FullLocationModel locationData,
      // required String startAddress,
      required String receiverName,
      required String receiverPhone,
      required int weight,
      required int objectType,
      required int workersNeeded}) async {
    return await repository.getThePriceOrTrip(
        weight: weight,
        objectType: objectType,
        workersNeeded: workersNeeded,
        locationData: locationData,
        userData: userData,
        // location: location,
        // startAddress: startAddress,
        receiverName: receiverName,
        receiverPhone: receiverPhone);
  }
}
