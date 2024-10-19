import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../core/enums/request_state.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/failures_messages.dart';
import '../../../core/utils.dart';
import '../../intro/domain/entities/get_stuff_types_model.dart';
import '../../intro/domain/entities/main_app_required.dart';
import '../../intro/domain/entities/user_data_model.dart';
import '../../intro/domain/use_cases/get_stuff_types_use_case.dart';
import '../../intro/domain/use_cases/get_user_data_use_case.dart';
import '../presentation/screen/name_screen.dart';

export 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  Timer? _countdownTimer;
  int initialCountdownSeconds = 0;
  int defaultTimeToStart = 10;
  bool reSendCode = false;
  final GetUserDataUseCases getUserDataUseCases;
  final GetStuffTypesDataUseCases getStuffTypesDataUseCases;

  AuthProvider(
      {required this.getUserDataUseCases,
      required this.getStuffTypesDataUseCases}) {
    print('AuthProvider');
    _getUserData();
    _getStuffTypesData();
  }
  RequestState stateOfHome = RequestState.initial;
  String? message;
  UserData? userData;
  MainAppRequiredModel? stuffTypesData;

  _getUserData() async {
    print('_getHomeData');
    stateOfHome = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await getUserDataUseCases();
    _eitherLoadedOrErrorState(failureOrDoneMessage);
  }

  _getStuffTypesData() async {
    print('_getHomeData');
    stateOfHome = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await getStuffTypesDataUseCases();
    _eitherLoadedOrErrorFRomStuffTypesState(failureOrDoneMessage);
  }

  _eitherLoadedOrErrorFRomStuffTypesState(
    Either<Failure, MainAppRequiredModel> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        message = _mapFailureToMessage(failure);
      },
      (data) {
        print('?.types:${data.types?.length}');
        stuffTypesData = data;
      },
    );
    notifyListeners();
  }

  _eitherLoadedOrErrorState(
    Either<Failure, UserData> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        message = _mapFailureToMessage(failure);
      },
      (data) {
        userData = data;
      },
    );
    notifyListeners();
  }

  void startCountdown() {
    reSendCode = false;
    initialCountdownSeconds = defaultTimeToStart;
    notifyListeners();

    print('startCountdown');
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (initialCountdownSeconds > 0) {
        initialCountdownSeconds--;
      } else {
        _countdownTimer!.cancel();
        reSendCode = true;
      }
      notifyListeners();
    });
  }

  doneOtp(BuildContext context) {
    Utils.navigateAndRemoveUntilTo(NameScreen(), context);
  }

  String currentOtp = '';
  updateCurrentOtp({required String char}) {
    currentOtp = char;
    notifyListeners();
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure _:
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
