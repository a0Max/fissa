import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../entities/predictions_model.dart';
import '../repositories/repositories_map.dart';

class SaveLocalSearchUseCases {
  final MapRepository repository;

  SaveLocalSearchUseCases(this.repository);

  Future<void> call({required String text}) async {
    print('saveTextLocal');
    return await repository.saveTextLocal(text: text);
  }
}
