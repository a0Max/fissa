import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../entities/predictions_model.dart';
import '../repositories/repositories_map.dart';

class MapInformationUseCases {
  final MapRepository repository;

  MapInformationUseCases(this.repository);

  Future<Either<Failure, List<PredictionsModel>>> call(
      {required String text,
      required LatLng latLng,
      required int radius}) async {
    return await repository.mapInformationDataRepository(
        text: text, radius: radius, latLng: latLng);
  }
}
