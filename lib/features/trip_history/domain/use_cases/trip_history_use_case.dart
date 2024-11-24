import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../repositories/repositories_trip_history.dart';

class TripHistoryUseCases {
  final RepositoriesTripHistory repository;

  TripHistoryUseCases(this.repository);

  Future<Either<Failure, List<TripDetailsModel>>> call() async {
    return await repository.getTripRequestHistory();
  }
}
