import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:fisaa/core/state_requests.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../../core/main_map_informations.dart';
import '../../domain/entities/predictions_model.dart';
import '../../domain/use_cases/map_information_use_cases.dart';

class MapInformation extends ChangeNotifier {
  final MapInformationUseCases mapInformationUseCases;
  StateOfTextField stateOfTextField = StateOfTextField.initial;
  List<PredictionsModel>? locations;
  String? message;

  MapInformation({required this.mapInformationUseCases}) {
    getUserLocation();
  }
  GoogleMapController? gmapController;
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();

  LatLng? kGooglePlex;
  Future<bool> _getLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Position? currentPosition;
  getUserLocation() async {
    final hasPermission = await _getLocation();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      notifyListeners();
      _getAddressFromLatLng(position);
      _updateKGooglePlex(position);
    }).catchError((e) {
      _addMarkFromUserLocation();
      debugPrint(e);
    });
  }

  _updateKGooglePlex(Position position) {
    kGooglePlex = LatLng(position.latitude, position.longitude);
    if (kGooglePlex != null) {
      gmapController?.animateCamera(CameraUpdate.newLatLng(kGooglePlex!));
      _addMarkFromUserLocation(position: position);
    }
    notifyListeners();
  }

  String? currentAddress;
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress =
          '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  final Set<Marker> markers = <Marker>{};
  _addMarkFromUserLocation({Position? position}) {
    markers.add(
      Marker(
        markerId: MarkerId(LatLng(
                position?.latitude ?? MainMapInformation.latitude,
                position?.longitude ?? MainMapInformation.longitude)
            .toString()),
        position: LatLng(position?.latitude ?? MainMapInformation.latitude,
            position?.longitude ?? MainMapInformation.longitude),
      ),
    );
    notifyListeners();
  }

  changeLocation(LatLng arg) {
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(LatLng(arg.latitude, arg.longitude).toString()),
        position: LatLng(arg.latitude, arg.longitude),
      ),
    );
    notifyListeners();
  }

  startSearch(
      {required String text,
      required LatLng latLng,
      required int radius}) async {
    stateOfTextField = StateOfTextField.loading;
    notifyListeners();

    _eitherLoadedOrErrorState(await mapInformationUseCases.call(
        text: text, radius: radius, latLng: latLng));
  }

  _eitherLoadedOrErrorState(
      Either<Failure, List<PredictionsModel>> failureOrTrivia) async {
    failureOrTrivia.fold(
      (failure) => _stateOfGetErrorMessage(failure),
      (data) => _stateOfSaveLocationsData(data),
    );
    notifyListeners();
  }

  _stateOfGetErrorMessage(Failure failure) {
    message = _mapFailureToMessage(failure);
  }

  _stateOfSaveLocationsData(List<PredictionsModel> data) {
    locations = data;
    stateOfTextField = StateOfTextField.done;
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case LoginFailure:
        return Login_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
