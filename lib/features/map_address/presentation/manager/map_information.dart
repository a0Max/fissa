import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/state_requests.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiver/strings.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/enums/state_of_search.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../../core/main_map_informations.dart';
import '../../domain/entities/location_model.dart';
import '../../domain/entities/predictions_model.dart';
import '../../domain/use_cases/map_information_use_cases.dart';

class MapInformation extends ChangeNotifier {
  final MapInformationUseCases mapInformationUseCases;
  StateOfTextField stateOfTextField = StateOfTextField.initial;
  List<PredictionsModel> locations = [];
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
      getAddressFromLatLng(position.latitude, position.longitude, '', true);
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

  Future<String> getAddressFromLatLng(double latitude, double longitude,
      String? deuletTex, bool? fromClickButton) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      String currentAddress =
          '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.country}';
      notifyListeners();
      if (fromClickButton == true) {
        startLocation = LocationModel(lat: latitude, lng: longitude);
        startAddress = currentAddress;
        notifyListeners();
      }
      return currentAddress;
    } catch (e) {
      if (isBlank(deuletTex) == true) {
        getAddressFromLatLng(latitude, longitude, deuletTex, fromClickButton);
      }
      return deuletTex ?? '';
    }
  }

  Future<BitmapDescriptor> _mainMarker({required String image}) async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.5), AppImages.marker);
  }

  final Set<Marker> markers = <Marker>{};
  _addMarkFromUserLocation({Position? position}) async {
    markers.add(
      Marker(
        icon: await _mainMarker(image: AppImages.marker),
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

  changeLocation(LatLng arg) async {
    markers.clear();
    markers.add(
      Marker(
        icon: await _mainMarker(image: AppImages.marker),
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

    await _eitherLoadedOrErrorState(await mapInformationUseCases(
        text: text, radius: radius, latLng: latLng));
    notifyListeners();
  }

  _eitherLoadedOrErrorState(
      Either<Failure, List<PredictionsModel>> failureOrTrivia) async {
    await failureOrTrivia.fold(
      (failure) => _stateOfGetErrorMessage(failure),
      (data) => _stateOfSaveLocationsData(data),
    );
    notifyListeners();
  }

  _stateOfGetErrorMessage(Failure failure) {
    message = _mapFailureToMessage(failure);
  }

  Future<void> _stateOfSaveLocationsData(List<PredictionsModel> data) async {
    locations.clear();

    List<PredictionsModel> _subData = await _handlingDataOfLocations(data);

    locations.addAll(_subData);
    notifyListeners();
  }

  Future<List<PredictionsModel>> _handlingDataOfLocations(
      List<PredictionsModel> data) async {
    List<PredictionsModel> _subData = [];

    for (var element in data) {
      var formattedAddress = await getAddressFromLatLng(
          element.geometry?.location?.lat ?? 0,
          element.geometry?.location?.lng ?? 0,
          element.formattedAddress,
          false);
      _subData.add(element.copyWith(formattedAddress: formattedAddress));
    }

    return _subData;
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

  StateOfSearch? startShowAddress;
  saveShowAddress({required StateOfSearch action}) {
    startShowAddress = action;
    notifyListeners();
  }

  LocationModel? startLocation;
  LocationModel? endLocation;
  String? endAddress;
  String? startAddress;
  saveStartLocation(
      {required LocationModel? location, required String address}) {
    if (startShowAddress == StateOfSearch.endPointSearch) {
      endLocation = location;
      endAddress = address;
      kGooglePlex = LatLng(location?.lat ?? 0, location?.lng ?? 0);
      gmapController?.animateCamera(CameraUpdate.newLatLng(kGooglePlex!));
    } else if (startShowAddress == StateOfSearch.firstPointSearch) {
      startLocation = location;
      startAddress = address;
      kGooglePlex = LatLng(location?.lat ?? 0, location?.lng ?? 0);
      gmapController?.animateCamera(CameraUpdate.newLatLng(kGooglePlex!));
    }
    locations.clear();
    startShowAddress = StateOfSearch.endSearch;
    notifyListeners();
  }

  clearStartSearch() {
    startLocation = null;
    startAddress = null;
    locations.clear();
    markers.clear();
    notifyListeners();
  }

  clearEndSearch() {
    endLocation = null;
    endAddress = null;
    locations.clear();
    markers.clear();

    notifyListeners();
  }

  bool checkEndPoint = false;
  updateCheckEndPoint({required bool updateCheck}) {
    checkEndPoint = updateCheck;
    if (updateCheck == true) {
      goToTheEndOfLocation();
    }
    notifyListeners();
  }

  goToTheEndOfLocation() {
    kGooglePlex = LatLng(endLocation?.lat ?? 0, endLocation?.lng ?? 0);
    gmapController?.animateCamera(CameraUpdate.newLatLng(kGooglePlex!));
  }

  Set<Polyline> polylines = {};

  drawTheDirection() async {
    markers.clear();
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

    kGooglePlex = LatLng(startLocation?.lat ?? 0, startLocation?.lng ?? 0);
    gmapController?.animateCamera(CameraUpdate.newLatLng(kGooglePlex!));
    markers.add(Marker(
        markerId: MarkerId(
            LatLng(startLocation?.lat ?? 0, startLocation?.lng ?? 0)
                .toString()),
        position: LatLng(startLocation?.lat ?? 0, startLocation?.lng ?? 0),
        icon: await _mainMarker(image: AppImages.markerFixCar)
        // infoWindow: InfoWindow(title: 'Point 1'),
        ));
    markers.add(Marker(
        markerId: MarkerId(
            LatLng(endLocation?.lat ?? 0, endLocation?.lng ?? 0).toString()),
        position: LatLng(endLocation?.lat ?? 0, endLocation?.lng ?? 0),
        icon: await _mainMarker(image: AppImages.endMarker)
        // infoWindow: InfoWindow(title: 'Point 1'),
        ));

    notifyListeners();
  }
}
