import 'package:dartz/dartz.dart';
import 'package:fisaa/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiver/strings.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../../core/utils.dart';
import '../../../intro/domain/entities/get_stuff_types_model.dart';
import '../../../intro/domain/entities/get_weight_model.dart';
import '../../../intro/domain/entities/get_workers_model.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../../domain/entities/trip_details_model.dart';
import '../../domain/use_cases/create_trip_of_transports_goods_use_case.dart';
import '../../domain/use_cases/get_price_trip_of_transports_goods_use_case.dart';
import '../pages/first_step_details.dart';
import '../pages/fourth_step_details.dart';
import '../pages/second_step_details.dart';
import '../pages/third_step_details.dart';
import '../widgets/complete_of_trip.dart';

class ManagerOfTransportGoods extends ChangeNotifier {
  final CreateTripOfTransportsGoodsUseCases createTripOfTransportsGoodsUseCases;
  final GetPriceTripOfTransportsGoodsUseCases
      getPriceTripOfTransportsGoodsUseCases;
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
      required List<GetWorkersModel> workersList,
      required this.getPriceTripOfTransportsGoodsUseCases,
      required this.locationData}) {
    _handlingWorkersCount(workersList);
  }
  GetWorkersModel? emptyWorker;
  List<GetWorkersModel>? listOfWorkers;
  _handlingWorkersCount(List<GetWorkersModel> workersList) {
    emptyWorker = workersList.firstWhere((element) => element.count == '0');
    workersList.removeWhere((element) => element.count == '0');
    listOfWorkers = workersList;
    notifyListeners();
  }

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
      if (selectTypeOfGood != null && selectWeightOfGood != null) {
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
      if (needWorkersObject != null) {
        stateOfNextButton = true;
        notifyListeners();
        return;
      }
    }

    stateOfNextButton = false;
    notifyListeners();
  }

  GetStuffTypesModel? selectTypeOfGood;
  GetWeightModel? selectWeightOfGood;
  updateSelectTypeOfGood({required GetStuffTypesModel typeOfGood}) {
    selectTypeOfGood = typeOfGood;
    notifyListeners();
    checkStateOfNextButton();
  }

  updateSelectWeightOfGood({required GetWeightModel typeOfGood}) {
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

  GetWorkersModel? needWorkersObject;
  updateNeedWorkers({required GetWorkersModel newData}) {
    print('newData:$newData');
    needWorkersObject = newData;
    notifyListeners();
    checkStateOfNextButton();
  }

  RequestState stateOfHome = RequestState.initial;
  String? message;
  TripDetailsModel? tripDetails;

  getTripDetails(
      {required UserData userData, required BuildContext context}) async {
    stateOfHome = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await createTripOfTransportsGoodsUseCases(
        weight: selectWeightOfGood?.id ?? 0,
        objectType: selectTypeOfGood?.id ?? 0,
        workersNeeded: needWorkersObject?.id ?? 0,
        locationData: locationData,
        userData: userData,
        // location: location,
        // startAddress: startAddress,
        receiverName: textFieldNameOfReceiver ?? '',
        receiverPhone: textFieldPhoneOfReceiver ?? '');
    _eitherLoadedOrErrorState(failureOrDoneMessage);
    notifyListeners();
    if (stateOfHome == RequestState.error) {
      Fluttertoast.showToast(
          msg: message ?? '',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.mainColor,
          textColor: Colors.white,
          fontSize: 16.0.sp);
    } else if (stateOfHome == RequestState.done) {
      Utils.showMainBottomSheetWithButton(context, CompleteOfTrip());
    }
  }

  _eitherLoadedOrErrorState(
    Either<Failure, TripDetailsModel> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        stateOfHome = RequestState.error;

        message = _mapFailureToMessage(failure);
      },
      (data) {
        stateOfHome = RequestState.done;

        tripDetails = data;
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
