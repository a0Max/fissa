import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../repositories/repositories_trip_of_puller.dart';

class GetPriceTripOfPullerUseCases {
  final RepositoriesTripOfPuller repository;

  GetPriceTripOfPullerUseCases(this.repository);

  Future<Either<Failure, String>> call(
      {required UserData userData,
      required FullLocationModel locationData,
      }) async {
    return await repository.getThePriceOrTrip(

        locationData: locationData,
        userData: userData,);
  }
}
