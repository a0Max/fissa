import 'package:dartz/dartz.dart';
import 'package:fisaa/core/assets_images.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../intro/domain/entities/get_stuff_types_model.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../../../map_address/domain/entities/location_model.dart';
import '../../domain/entities/trip_details_model.dart';
import '../../domain/entities/type_of_good_model.dart';
import '../../domain/use_cases/create_trip_of_transports_goods_use_case.dart';
import '../pages/first_step_details.dart';
import '../pages/fourth_step_details.dart';
import '../pages/second_step_details.dart';
import '../pages/third_step_details.dart';

class ManagerOfTransportGoods extends ChangeNotifier {
  final CreateTripOfTransportsGoodsUseCases createTripOfTransportsGoodsUseCases;
  final FullLocationModel locationData;
  int indexOfStep = 0;
  List<Widget> widgetsOfSteps = [
    FirstStepDetails(),
    SecondStepDetails(),
    ThirdStepDetails(),
    FourthStepDetails(),
  ];
  bool stateOfNextButton = false;

  ManagerOfTransportGoods(
      {required this.createTripOfTransportsGoodsUseCases,
      required this.locationData});
  void updateIndexOfStep() {
    indexOfStep++;
    stateOfNextButton = false;
    notifyListeners();
  }

  void updateIndexOfStepToDownGrade() {
    indexOfStep--;
    stateOfNextButton = true;
    notifyListeners();
  }

  checkStateOfNextButton() {
    if (indexOfStep == 0) {
      if (selectTypeOfGood != 0 && selectWeightOfGood != 0) {
        stateOfNextButton = true;
        notifyListeners();
        return;
      }
    } else if (indexOfStep == 1) {
      if (payWhenReceive == true &&
          isBlank(textFieldNameOfReceiver) == false &&
          isBlank(textFieldPhoneOfReceiver) == false) {
        stateOfNextButton = true;
        notifyListeners();
        return;
      }
    } else if (indexOfStep == 2) {
      if (needWorkers != null) {
        stateOfNextButton = true;
        notifyListeners();
        return;
      }
    }

    stateOfNextButton = false;
    notifyListeners();
  }

  GetStuffTypesModel? selectTypeOfGood;
  List<TypeOfGoodModel> listOfWeightOfGoods = [
    TypeOfGoodModel(
      goodKey: 1,
      title: '+100 ك.ج',
    ),
    TypeOfGoodModel(goodKey: 2, title: '+200 ك.ج'),
    TypeOfGoodModel(goodKey: 3, title: '+300 ك.ج'),
    TypeOfGoodModel(goodKey: 4, title: '+400 ك.ج'),
    TypeOfGoodModel(goodKey: 5, title: '+500 ك.ج'),
    TypeOfGoodModel(goodKey: 6, title: '+600 ك.ج'),
    TypeOfGoodModel(goodKey: 7, title: '+700 ك.ج'),
  ];

  TypeOfGoodModel? selectWeightOfGood;
  updateSelectTypeOfGood({required GetStuffTypesModel typeOfGood}) {
    selectTypeOfGood = typeOfGood;
    notifyListeners();
    checkStateOfNextButton();
  }

  updateSelectWeightOfGood({required TypeOfGoodModel typeOfGood}) {
    selectWeightOfGood = typeOfGood;
    notifyListeners();
    checkStateOfNextButton();
  }

  String? textFieldNameOfReceiver;
  String? textFieldPhoneOfReceiver;
  bool payWhenReceive = false;

  updateNameOfReceiver({required String? newText}) {
    textFieldNameOfReceiver = newText;
    notifyListeners();
    checkStateOfNextButton();
  }

  updatePhoneOfReceiver({required String? newText}) {
    textFieldPhoneOfReceiver = newText;
    notifyListeners();
    checkStateOfNextButton();
  }

  updatePayWhenReceive() {
    payWhenReceive = !payWhenReceive;
    notifyListeners();
    checkStateOfNextButton();
  }

  int? needWorkers;
  updateNeedWorkers({required int newData}) {
    needWorkers = newData;
    notifyListeners();
    checkStateOfNextButton();
  }

  RequestState stateOfHome = RequestState.initial;
  String? message;
  TripDetailsModel? tripDetails;

  getTripDetails({required UserData userData}) async {
    stateOfHome = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await createTripOfTransportsGoodsUseCases(
        weight: selectWeightOfGood?.title ?? '',
        objectType: selectTypeOfGood?.name ?? '',
        workersNeeded: needWorkers ?? 0,
        locationData: locationData,
        userData: userData,
        // location: location,
        // startAddress: startAddress,
        receiverName: textFieldNameOfReceiver ?? '',
        receiverPhone: textFieldPhoneOfReceiver ?? '');
    _eitherLoadedOrErrorState(failureOrDoneMessage);
    notifyListeners();
  }

  _eitherLoadedOrErrorState(
    Either<Failure, TripDetailsModel> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        message = _mapFailureToMessage(failure);
      },
      (data) {
        tripDetails = data;
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
