import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:fisaa/features/home/domain/entities/home_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/enums/request_state.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../domain/use_cases/get_home_data_use_cases.dart';

class HomeProvider extends ChangeNotifier {
  final GetHomeDataUseCases getHomeDataUseCases;
  HomeProvider({required this.getHomeDataUseCases}) {
    print('HomeProvider');
    log('HomeProvider');
    _getHomeData();
  }
  RequestState stateOfHome = RequestState.initial;
  String? message;
  HomeModel? homeData;

  _getHomeData() async {
    stateOfHome = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await getHomeDataUseCases();
    _eitherLoadedOrErrorState(failureOrDoneMessage);
    notifyListeners();
  }

  _eitherLoadedOrErrorState(
    Either<Failure, HomeModel> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        message = _mapFailureToMessage(failure);
      },
      (data) {
        homeData = data;
      },
    );
    stateOfHome = RequestState.done;

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
