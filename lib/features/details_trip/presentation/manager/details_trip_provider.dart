import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../../core/utils.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../order_puller/domain/use_cases/cancel_trip_of_puller_use_case.dart';

class DetailsTripProvider extends ChangeNotifier {
  final TripDetailsModel currentTrip;
  final CancelTripOfPullerUseCases cancelTripOfPullerUseCases;

  DetailsTripProvider(
      {required this.cancelTripOfPullerUseCases, required this.currentTrip}) {
    print('##:${currentTrip.id}');
  }

  bool showFirst = false;
  changeShowFirst() {
    showFirst = !showFirst;
    notifyListeners();
  }

  bool showSecond = false;
  changeShowSecond() {
    showSecond = !showSecond;
    notifyListeners();
  }

  RequestState stateOfCancel = RequestState.initial;

  _eitherCancelLoadedOrErrorState(
    Either<Failure, bool> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        stateOfCancel = RequestState.error;
      },
      (data) {
        stateOfCancel = RequestState.done;
      },
    );

    notifyListeners();
  }

  cancelTheCurrentTrip(BuildContext context) async {
    stateOfCancel = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage =
        await cancelTripOfPullerUseCases(tripId: currentTrip.id ?? 0);
    _eitherCancelLoadedOrErrorState(failureOrDoneMessage);
    notifyListeners();
    if (stateOfCancel == RequestState.done) {
      Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
    }
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
