import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/get_stuff_types_model.dart';
import '../repositories/repositories_intro.dart';

class GetStuffTypesDataUseCases {
  final IntroRepository repository;

  GetStuffTypesDataUseCases(this.repository);

  Future<Either<Failure, List<GetStuffTypesModel>>> call() async {
    return await repository.getStuffTypesDataRepository();
  }
}
