import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../entities/predictions_model.dart';
import '../repositories/repositories_map.dart';

class GetLocalSearchUseCases {
  final MapRepository repository;

  GetLocalSearchUseCases(this.repository);

  Future<List<String>> call() async {
    return await repository.getLocalTextSearch();
  }
}
