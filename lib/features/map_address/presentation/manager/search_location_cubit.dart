import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../domain/entities/predictions_model.dart';
import '../../domain/use_cases/map_information_use_cases.dart';

part 'search_location_state.dart';

class SearchLocationCubit extends Cubit<SearchLocationInitial> {
  final MapInformationUseCases mapInformationUseCases;

  SearchLocationCubit({required this.mapInformationUseCases})
      : super(
            SearchLocationInitial(stateOfTextField: StateOfTextField.initial));

  startSearch({required String text, required LatLng latLng, required int radius}) async {
    emit(SearchLocationInitial(stateOfTextField: StateOfTextField.loading));
    _eitherLoadedOrErrorState(await mapInformationUseCases.call(text: text, radius:radius, latLng:latLng));
  }

  Future<SearchLocationInitial> _eitherLoadedOrErrorState(
      Either<Failure, List<PredictionsModel>> failureOrTrivia) async {
    SearchLocationInitial tempState = failureOrTrivia.fold(
      (failure) => SearchLocationInitial(
          message: _mapFailureToMessage(failure),
          stateOfTextField: StateOfTextField.error),
      (data) => SearchLocationInitial(
          locations: data, stateOfTextField: StateOfTextField.done),
    );
    return tempState;
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case LoginFailure:
        return Login_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
