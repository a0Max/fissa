import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';

abstract class RepositoriesTripHistory {
  Future<Either<Failure, List<TripDetailsModel>>> getTripRequestHistory();
}
