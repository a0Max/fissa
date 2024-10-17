import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/home_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getHomeDataRepository();
}
