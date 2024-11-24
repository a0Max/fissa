import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../repositories/reorder_trip.dart';

class ReOrderTripUseCases {
  final RepositoriesTripReOrder repository;

  ReOrderTripUseCases(this.repository);

  Future<Either<Failure, TripDetailsModel>> call(
      {required TripDetailsModel currentTrip}) async {
    return await repository.sendTripRequestCreate(currentTrip: currentTrip);
  }
}
