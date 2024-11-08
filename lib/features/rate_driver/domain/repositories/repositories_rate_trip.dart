import 'package:dartz/dartz.dart';
import 'package:fisaa/features/intro/domain/entities/user_data_model.dart';
import '../../../../core/error/failures.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';

abstract class RepositoriesRateTrip {
  Future<Either<Failure, bool>> rateTrip(
      {required int tripId, required int rating});
}
