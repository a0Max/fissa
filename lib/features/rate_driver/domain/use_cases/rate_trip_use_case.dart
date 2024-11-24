import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../repositories/repositories_rate_trip.dart';

class RateTripUseCases {
  final RepositoriesRateTrip repository;

  RateTripUseCases(this.repository);

  Future<Either<Failure, bool>> call({required int tripId, required int rating}) async {
    return await repository.rateTrip(tripId: tripId, rating:rating);
  }
}
