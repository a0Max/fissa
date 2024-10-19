import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/get_stuff_types_model.dart';
import '../entities/main_app_required.dart';
import '../entities/user_data_model.dart';

abstract class IntroRepository {
  Future<Either<Failure, UserData>> getUserDataRepository();
  Future<Either<Failure, MainAppRequiredModel>> getStuffTypesDataRepository();
}
