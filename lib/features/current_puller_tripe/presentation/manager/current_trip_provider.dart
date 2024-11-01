import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/app_color.dart';
import '../../../../core/assets_images.dart';
import '../../../../core/enums/request_state.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../../core/map_service.dart';
import '../../../../core/utils.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../order_puller/domain/entities/data_of_trip_puller_model.dart';
import '../../../order_puller/domain/use_cases/cancel_trip_of_puller_use_case.dart';
import '../../domain/entities/current_trip_model.dart';

class CurrentTripProvider extends ChangeNotifier {
  late DataOfTripePullerModel dataOfTrip;
  final CancelTripOfPullerUseCases cancelTripOfPullerUseCases;
  final LocationService locationService;

  CurrentTripProvider(
      {required this.locationService,
      required this.cancelTripOfPullerUseCases});
  saveTripData({required DataOfTripePullerModel tempDataOfTrip}) {
    dataOfTrip = tempDataOfTrip;
    print(
        "myProvider.fullTripDetailsWithDriver:${tempDataOfTrip.tripDetails?.price}");
    print(
        "myProvider.fullTripDetailsWithDriver:${tempDataOfTrip.driverId?.name}");
    notifyListeners();
    makeMarkerOfPassengerLocation();
    connectTheSocketToCheckIfTheTripAccept();
  }

  final Set<Marker> markers = <Marker>{};
  GoogleMapController? gmapController;
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  LatLng? kGooglePlex;

  makeMarkerOfPassengerLocation() async {
    markers.add(
      Marker(
        icon: await locationService.getTheMarker(image: AppImages.marker),
        markerId: MarkerId(LatLng(
                double.parse(dataOfTrip.tripDetails?.fromLat ?? '0'),
                double.parse(dataOfTrip.tripDetails?.fromLng ?? '0'))
            .toString()),
        position: LatLng(double.parse(dataOfTrip.tripDetails?.fromLat ?? '0'),
            double.parse(dataOfTrip.tripDetails?.fromLng ?? '0')),
      ),
    );
    markers.add(
      Marker(
        icon: await locationService.getTheMarker(image: AppImages.pullerCar),
        markerId: MarkerId(LatLng(
                double.parse(dataOfTrip.tripDetails?.toLat ?? '0'),
                double.parse(dataOfTrip.tripDetails?.toLng ?? '0'))
            .toString()),
        position: LatLng(double.parse(dataOfTrip.tripDetails?.toLat ?? '0'),
            double.parse(dataOfTrip.tripDetails?.toLng ?? '0')),
      ),
    );
    kGooglePlex = LatLng(double.parse(dataOfTrip.tripDetails?.toLat ?? '0'),
        double.parse(dataOfTrip.tripDetails?.toLng ?? '0'));
    Future.delayed(Duration(milliseconds: 500), () {
      gmapController?.animateCamera(CameraUpdate.newLatLng(kGooglePlex!));
    });
    notifyListeners();
  }

  updateTheCarLocation() async {
    markers.clear();
    markers.add(
      Marker(
        icon: await locationService.getTheMarker(image: AppImages.marker),
        markerId: MarkerId(LatLng(
                double.parse(dataOfTrip.tripDetails?.fromLat ?? '0'),
                double.parse(dataOfTrip.tripDetails?.fromLng ?? '0'))
            .toString()),
        position: LatLng(double.parse(dataOfTrip.tripDetails?.fromLat ?? '0'),
            double.parse(dataOfTrip.tripDetails?.fromLng ?? '0')),
      ),
    );
    markers.add(
      Marker(
        icon: await locationService.getTheMarker(image: AppImages.pullerCar),
        markerId: MarkerId(LatLng(double.parse(currentTripData?.lat ?? '0'),
                double.parse(currentTripData?.lng ?? '0'))
            .toString()),
        position: LatLng(double.parse(currentTripData?.lat ?? '0'),
            double.parse(currentTripData?.lng ?? '0')),
      ),
    );

    kGooglePlex = LatLng(double.parse(currentTripData?.lat ?? '0'),
        double.parse(currentTripData?.lng ?? '0'));
    gmapController?.animateCamera(CameraUpdate.newLatLng(kGooglePlex!));
    notifyListeners();
  }

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  Future<void> connectTheSocketToCheckIfTheTripAccept() async {
    await pusher.init(
        apiKey: 'ca1425e5b9febf7db616',
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onConnectionStateChange: onConnectionStateChange,
        cluster: 'eu');
    await pusher.subscribe(
        channelName:
            'trip.passenger.${dataOfTrip.tripDetails?.passengerId ?? 0}');
    await pusher.connect();
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  CurrentTripModel? currentTripData;
  DataOfTripePullerModel? newTripDetailsWithDriver;
  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onEvent(PusherEvent event) {
    try {
      print('event:${event.channelName} - ${event.eventName} - ${event.data}');
      if (event.eventName == "App\\Events\\DriverTripLocationUpdate") {
        currentTripData =
            CurrentTripModel.fromJson(json.decode(event.data.toString()));

        notifyListeners();
        updateTheCarLocation();
      }
    } catch (e) {
      log("Failed to parse event data: $e");
    }
  }

  closeTheSocketOfWaitingAccept() async {
    await pusher.disconnect();
  }

  @override
  void dispose() {
    closeTheSocketOfWaitingAccept();
    super.dispose();
  }

  RequestState stateOfCancel = RequestState.initial;
  String? message;

  _eitherCancelLoadedOrErrorState(
    Either<Failure, bool> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        stateOfCancel = RequestState.error;

        message = _mapFailureToMessage(failure);
      },
      (data) {
        stateOfCancel = RequestState.done;
      },
    );

    notifyListeners();
  }

  cancelTheCurrentTrip(BuildContext context) async {
    var stateOfCancel = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await cancelTripOfPullerUseCases(
        tripId: dataOfTrip.tripDetails?.id ?? 0);
    _eitherCancelLoadedOrErrorState(failureOrDoneMessage);
    notifyListeners();
    if (stateOfCancel == RequestState.done) {
      Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
    } else if (stateOfCancel == RequestState.error) {
      Fluttertoast.showToast(
          msg: message ?? '',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.mainColor,
          textColor: Colors.white,
          fontSize: 16.0.sp);
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