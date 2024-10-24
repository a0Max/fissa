import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../entities/predictions_model.dart';

abstract class MapRepository {
  Future<Either<Failure, List<PredictionsModel>>> mapInformationDataRepository(
      {required String text, required LatLng latLng, required int radius});
  Future<List<String>> getLocalTextSearch();
  Future<void> saveTextLocal({required String text});
}
