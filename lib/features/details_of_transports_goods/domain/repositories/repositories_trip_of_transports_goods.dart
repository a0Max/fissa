import 'package:dartz/dartz.dart';
import 'package:fisaa/features/intro/domain/entities/user_data_model.dart';
import '../../../../core/error/failures.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../entities/trip_details_model.dart';

abstract class RepositoriesTripOfTransportsGoods {
  Future<Either<Failure, TripDetailsModel>> sendTripRequestCreate(
      {required UserData userData,
      required FullLocationModel locationData,
      // required String startAddress,
      required String receiverName,
      required String receiverPhone,
      required String weight,
      required int objectType,
      required int workersNeeded});
}
