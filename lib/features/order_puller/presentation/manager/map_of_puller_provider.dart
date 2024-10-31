import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/app_color.dart';
import '../../../../core/assets_images.dart';
import '../../../../core/enums/request_state.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../../core/map_service.dart';
import '../../../../core/utils.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../login/presentation/manager/auth_provider.dart';
import '../../../map_address/domain/entities/full_location_model.dart';
import '../../../map_address/domain/entities/location_model.dart';
import '../../../map_address/presentation/widget/body_of_bottom_sheet.dart';
import '../../domain/entities/data_of_trip_puller_model.dart';
import '../../domain/use_cases/cancel_trip_of_puller_use_case.dart';
import '../../domain/use_cases/create_trip_of_puller_use_case.dart';
import '../../domain/use_cases/get_price_trip_of_puller_use_case.dart';
import '../widgets/body_of_bottom_sheet_for_puller.dart';
import '../widgets/check_the_address.dart';
import '../widgets/the_way_of_payment.dart';
import '../widgets/waiting_accept_from_driver.dart';

class MapOfPullerProvider extends ChangeNotifier {
  final CreateTripOfPullerUseCases createTripOfPullerUseCases;
  final GetPriceTripOfPullerUseCases getPriceTripOfPullerUseCases;
  final CancelTripOfPullerUseCases cancelTripOfPullerUseCases;
  final LocationService locationService;

  Widget? currentWidget = CheckTheAddress();
  MapOfPullerProvider(
      {required this.createTripOfPullerUseCases,
      required this.locationService,
      required this.cancelTripOfPullerUseCases,
      required this.getPriceTripOfPullerUseCases});

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
    stateOfCancel = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage =
        await cancelTripOfPullerUseCases(tripId: tripDetails?.id ?? 0);
    _eitherCancelLoadedOrErrorState(failureOrDoneMessage);
    notifyListeners();
    if (stateOfCancel == RequestState.done) {
      Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
    }
  }

  List<Widget> listOfWidget = [
    CheckTheAddress(),
    TheWayOfPayment(),
    WaitingAcceptFromDriver()
  ];
  int indexOfWidget = 0;
  updateTheIndex() {
    indexOfWidget = indexOfWidget + 1;
    currentWidget = listOfWidget[indexOfWidget];
    notifyListeners();
  }

  GoogleMapController? gmapController;
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  final Set<Marker> markers = <Marker>{};

  LocationModel? startLocation;
  LocationModel? endLocation;
  Set<Polyline> polylines = {};
  LatLng? kGooglePlex;

  RequestState stateOfCreateTrip = RequestState.initial;
  RequestState stateOfPrice = RequestState.initial;
  RequestState stateOfCancel = RequestState.initial;
  String? priceOfTripe;
  TripDetailsModel? tripDetails;
  String? message;

  _eitherPriceLoadedOrErrorState(
    Either<Failure, String> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        stateOfPrice = RequestState.error;

        message = _mapFailureToMessage(failure);
      },
      (data) {
        stateOfPrice = RequestState.done;

        priceOfTripe = data;
      },
    );

    notifyListeners();
  }

  UserData? userData;
  FullLocationModel? locationData;

  onStartGetDataOfTrip(
      {required UserData tempUserData,
      // required BuildContext context,
      required FullLocationModel tempLocationData}) {
    userData = tempUserData;
    locationData = tempLocationData;
    startLocation = tempLocationData.startLocation;
    endLocation = tempLocationData.endLocation;
    notifyListeners();

    drawTheDirection();
    getPriceOfTrip();
  }

  void showBottomSheet(BuildContext context) {
    final mapInformation = context.read<MapOfPullerProvider>();

    Utils.showCustomBottomSheetWithButton(
      context,
      ChangeNotifierProvider<MapOfPullerProvider>.value(
          value: mapInformation, child: BodyOfBottomSheetOfPuller()),
    );
    currentWidget = CheckTheAddress();
    notifyListeners();
  }

  getPriceOfTrip() async {
    stateOfPrice = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await getPriceTripOfPullerUseCases(
        locationData: locationData!, userData: userData!);
    _eitherPriceLoadedOrErrorState(failureOrDoneMessage);
    notifyListeners();
  }

  drawTheDirection() async {
    Polyline polyline = Polyline(
      polylineId: PolylineId("line1"),
      visible: true,
      points: [
        LatLng(startLocation?.lat ?? 0, startLocation?.lng ?? 0),
        LatLng(endLocation?.lat ?? 0, endLocation?.lng ?? 0)
      ],
      color: AppColor.yellowColor,
      width: 5,
    );
    polylines.add(polyline);

    markers.add(Marker(
      markerId: MarkerId(
          LatLng(startLocation?.lat ?? 0, startLocation?.lng ?? 0).toString()),
      position: LatLng(startLocation?.lat ?? 0, startLocation?.lng ?? 0),
      icon: await locationService.getTheMarker(image: AppImages.markerFixCar),
    ));
    markers.add(Marker(
      markerId: MarkerId(
          LatLng(endLocation?.lat ?? 0, endLocation?.lng ?? 0).toString()),
      position: LatLng(endLocation?.lat ?? 0, endLocation?.lng ?? 0),
      icon: await locationService.getTheMarker(image: AppImages.endMarker),
    ));

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        (startLocation?.lat ?? 0) < (endLocation?.lat ?? 0)
            ? (startLocation?.lat ?? 0)
            : (endLocation?.lat ?? 0),
        (startLocation?.lng ?? 0) < (endLocation?.lng ?? 0)
            ? (startLocation?.lng ?? 0)
            : (endLocation?.lng ?? 0),
      ),
      northeast: LatLng(
        (startLocation?.lat ?? 0) > (endLocation?.lat ?? 0)
            ? (startLocation?.lat ?? 0)
            : (endLocation?.lat ?? 0),
        (startLocation?.lng ?? 0) > (endLocation?.lng ?? 0)
            ? (startLocation?.lng ?? 0)
            : (endLocation?.lng ?? 0),
      ),
    );

    if (gmapController != null) {
      Future.delayed(Duration(milliseconds: 500), () {
        CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 100);
        gmapController?.animateCamera(cameraUpdate);
      });
    }
    notifyListeners();
  }

  int selectedWayOfPayment = 0;
  submitWayOfPayment(int newWay) {
    selectedWayOfPayment = newWay;
    notifyListeners();
    print('selectedWayOfPayment:$selectedWayOfPayment');
  }

  _eitherLoadedOrErrorState(
    Either<Failure, TripDetailsModel> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        stateOfCreateTrip = RequestState.error;

        message = _mapFailureToMessage(failure);
      },
      (data) {
        stateOfCreateTrip = RequestState.done;

        tripDetails = data;
        updateTheIndex();
        connectTheSocketToCheckIfTheTripAccept();
      },
    );

    notifyListeners();
  }

  createTripDetails() async {
    print('createTripDetails:');
    stateOfCreateTrip = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await createTripOfPullerUseCases(
        locationData: locationData!, userData: userData!);
    _eitherLoadedOrErrorState(failureOrDoneMessage);
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
    await pusher.subscribe(channelName: 'trips.${tripDetails?.id ?? 0}');
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

  DataOfTripePullerModel? fullTripDetailsWithDriver;
  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onEvent(PusherEvent event) {
    try {
      print('event:${event.channelName} - ${event.eventName} - ${event.data}');
      log('${event.data}');
      if (event.eventName == "App\\Events\\TripAccepted") {
        fullTripDetailsWithDriver =
            DataOfTripePullerModel.fromJson(json.decode(event.data.toString()));
        print(
            'fullTripDetailsWithDriver:${fullTripDetailsWithDriver?.tripDetails?.price}');
        closeTheSocketOfWaitingAccept();
        notifyListeners();
      }
    } catch (e) {
      log("Failed to parse event data: $e");
    }
  }

  closeTheSocketOfWaitingAccept() async {
    await pusher.disconnect();
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
