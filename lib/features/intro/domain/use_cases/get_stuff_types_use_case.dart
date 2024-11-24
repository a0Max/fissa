import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/get_stuff_types_model.dart';
import '../entities/main_app_required.dart';
import '../repositories/repositories_intro.dart';

class GetStuffTypesDataUseCases {
  final IntroRepository repository;

  GetStuffTypesDataUseCases(this.repository);

  Future<Either<Failure, MainAppRequiredModel>> call() async {
    return await repository.getStuffTypesDataRepository();
  }
}
