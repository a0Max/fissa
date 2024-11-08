import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../../core/utils.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../domain/use_cases/rate_trip_use_case.dart';

class RateDriverProvider extends ChangeNotifier {
  double rate = 0;
  final RateTripUseCases rateTripUseCases;
  RateDriverProvider({required this.rateTripUseCases});
  updateTheRate(double newRate) {
    rate = newRate;
    notifyListeners();
    updateTheTextOfRate();
  }

  String textOfRate = '';
  updateTheTextOfRate() {
    switch (rate) {
      case 0:
        textOfRate = '';
      case 1:
        textOfRate = 'سيئ 😡';
      case 2:
        textOfRate = 'مقبول 😒';
      case 3:
        textOfRate = 'جيدة 🙂';
      case 4:
        textOfRate = 'جيدة جداً 🥳';
      case 5:
        textOfRate = 'ممتاز 🤩';
    }
    notifyListeners();
  }

  RequestState stateOfRate = RequestState.initial;
  String? message;

  _eitherRateLoadedOrErrorState(
    Either<Failure, bool> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        stateOfRate = RequestState.error;

        message = _mapFailureToMessage(failure);
      },
      (data) {
        stateOfRate = RequestState.done;
      },
    );

    notifyListeners();
  }

  cancelTheCurrentTrip(BuildContext context, int tripId) async {
    stateOfRate = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage =
        await rateTripUseCases(tripId: tripId, rating: rate.toInt());
    _eitherRateLoadedOrErrorState(failureOrDoneMessage);
    notifyListeners();
    if (stateOfRate == RequestState.done) {
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
