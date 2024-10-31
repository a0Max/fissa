import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../repositories/repositories_trip_of_puller.dart';

class CreateTripOfPullerUseCases {
  final RepositoriesTripOfPuller repository;

  CreateTripOfPullerUseCases(this.repository);

  Future<Either<Failure, TripDetailsModel>> call(
      {required UserData userData,
      required FullLocationModel locationData}) async {
    return await repository.sendTripRequestCreate(
      locationData: locationData,
      userData: userData,
    );
  }
}
