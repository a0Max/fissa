import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/enums/state_of_ride.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../domain/use_cases/trip_history_use_case.dart';

class TripHistoryProvider extends ChangeNotifier {
  final TripHistoryUseCases tripHistoryUseCases;
  TripHistoryProvider({required this.tripHistoryUseCases});
  RequestState stateOfHistory = RequestState.initial;
  List<TripDetailsModel> allHistoryTrips = [];
  List<TripDetailsModel> cancelHistoryTrips = [];
  List<TripDetailsModel> completedHistoryTrips = [];
  String? message;

  _eitherLoadedOrErrorState(
    Either<Failure, List<TripDetailsModel>> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        stateOfHistory = RequestState.error;

        message = _mapFailureToMessage(failure);
      },
      (data) {
        stateOfHistory = RequestState.done;
        allHistoryTrips = data;
        cancelHistoryTrips = data
            .where((element) => element.status == StateOfRide.cancel.text())
            .toList();
        completedHistoryTrips = data
            .where((element) => element.status == StateOfRide.completed.text())
            .toList();
      },
    );
    notifyListeners();
  }

  getHistoryTrips() async {
    stateOfHistory = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await tripHistoryUseCases();
    _eitherLoadedOrErrorState(failureOrDoneMessage);
    notifyListeners();
    if (stateOfHistory == RequestState.done) {
      _handlingTheCountStateOfTrips();
    }
  }

  int? countOfCancel;
  int? countOfAll;
  int? countOfCompleted;

  _handlingTheCountStateOfTrips() {
    countOfCancel = cancelHistoryTrips.length;
    countOfCompleted = completedHistoryTrips.length;
    countOfAll = allHistoryTrips.length;
    notifyListeners();
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      if (failure is ServerFailure) {
        return failure.message;
      }
      return SERVER_FAILURE_MESSAGE;
    case LoginFailure:
      return Login_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    case ReLoginFailure:
      return RELOGIN_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
