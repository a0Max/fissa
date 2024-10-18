import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fisaa/features/home/domain/entities/home_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../domain/use_cases/get_home_data_use_cases.dart';

enum HomeState { loading, error, done, initial }

class HomeProvider extends ChangeNotifier {
  final GetHomeDataUseCases getHomeDataUseCases;
  HomeProvider({required this.getHomeDataUseCases}) {
    print('HomeProvider');
    log('HomeProvider');
    _getHomeData();
  }
  HomeState stateOfHome = HomeState.initial;
  String? message;
  HomeModel? homeData;

  _getHomeData() async {
    print('_getHomeData');
    log('_getHomeData');
    stateOfHome = HomeState.loading;
    notifyListeners();

    final failureOrDoneMessage = await getHomeDataUseCases();
    _eitherLoadedOrErrorState(failureOrDoneMessage);
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
