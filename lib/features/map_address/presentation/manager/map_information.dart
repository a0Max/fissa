import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:fisaa/core/app_color.dart';
import 'package:fisaa/core/state_requests.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiver/strings.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/enums/selected_help.dart';
import '../../../../core/enums/state_of_search.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../../core/main_map_informations.dart';
import '../../domain/entities/location_model.dart';
import '../../domain/entities/predictions_model.dart';
import '../../domain/use_cases/get_local_search_use_cases.dart';
import '../../domain/use_cases/map_information_use_cases.dart';
import '../../domain/use_cases/save_local_search_use_cases.dart';
import '../../../order_puller/presentation/widgets/check_the_address.dart';
import '../../../order_puller/presentation/widgets/waiting_accept_from_driver.dart';
import '../widget/make_sure_about_the_end_point.dart';
import '../../../order_puller/presentation/widgets/the_way_of_payment.dart';

class MapInformation extends ChangeNotifier {
  final MapInformationUseCases mapInformationUseCases;
  final GetLocalSearchUseCases getLocalSearchUseCases;
  final SaveLocalSearchUseCases saveLocalSearchUseCases;
  StateOfTextField stateOfTextField = StateOfTextField.initial;
  List<PredictionsModel> locations = [];
  String? message;

  MapInformation(
      {required this.getLocalSearchUseCases,
      required this.saveLocalSearchUseCases,
      required this.mapInformationUseCases}) {
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
      // isAnimatingCamera = false;
      // notifyListeners();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      String currentAddress =
          '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.country}';
      notifyListeners();
      if (fromClickButton == true) {
        print(
            'startShowAddress:$startShowAddress -${(startShowAddress == StateOfSearch.endPointSearch)}');
        if (startShowAddress == StateOfSearch.endPointSearch) {
          endLocation = LocationModel(lat: latitude, lng: longitude);
          endAddress = currentAddress;
        } else {
          startLocation = LocationModel(lat: latitude, lng: longitude);
          startAddress = currentAddress;
        }

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
        ImageConfiguration(devicePixelRatio: 3.5), image);
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
    if (checkEndPoint == true) {
      return;
    }
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

  StateOfSearchTextField? startSearchTextField;
  List<String> historyOfSearch = [];
  Future<void> searchText({required StateOfSearchTextField action}) async {
    startSearchTextField = action;
    if (action == StateOfSearchTextField.click) {
      historyOfSearch = await getLocalSearchUseCases();
    }
    notifyListeners();
  }

  Future<void> saveSearchText({required String text}) async {
    print('saveSearchText');
    await saveLocalSearchUseCases(text: text);
  }

  StateOfSearch? startShowAddress;
  saveShowAddress({required StateOfSearch action}) {
    startShowAddress = action;
    notifyListeners();
    if (startLocation != null && action == StateOfSearch.firstPointSearch) {
      changeLocation(LatLng(startLocation?.lat ?? 0, startLocation?.lng ?? 0));
      gmapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(startLocation?.lat ?? 0, startLocation?.lng ?? 0)));
      notifyListeners();
    } else if (endLocation != null && action == StateOfSearch.endPointSearch) {
      changeLocation(LatLng(endLocation?.lat ?? 0, endLocation?.lng ?? 0));
      gmapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(endLocation?.lat ?? 0, endLocation?.lng ?? 0)));
      notifyListeners();
    }
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
    print('startShowAddress:$startShowAddress');
    print('startAddress:$startAddress');
    print('endAddress:$endAddress');
    locations.clear();
    startShowAddress = StateOfSearch.endPointSearch;
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
    polylines.clear();
    currentWidget = MakeSureAboutTheEndPoint();
    indexOfCurrentWidget = 0;
    notifyListeners();
    // if (updateCheck == true) {
    goToTheEndOfLocation();
    // }
    notifyListeners();
  }

  goToTheEndOfLocation() {
    kGooglePlex = LatLng(endLocation?.lat ?? 0, endLocation?.lng ?? 0);
    gmapController?.animateCamera(CameraUpdate.newLatLng(kGooglePlex!));
  }

  Set<Polyline> polylines = {};

  Widget currentWidget = MakeSureAboutTheEndPoint();
  int indexOfCurrentWidget = 0;
  late SelectedHelp typeOfHelp;
  submitTypeOfHelp({required SelectedHelp newTypeOfHelp}) {
    typeOfHelp = newTypeOfHelp;
    notifyListeners();
  }

  updateTheIndexAndCurrentWidgetOfTransportOfGoods({required int index}) {
    switch (index) {
      case 0:
        currentWidget = MakeSureAboutTheEndPoint();
    }
    notifyListeners();
  }

  updateTheIndexAndCurrentWidgetOfVehicleTowing({required int index}) {
    print('index:$index');
    switch (index) {
      case 0:
        currentWidget = MakeSureAboutTheEndPoint();
      case 1:
        currentWidget = CheckTheAddress();
      case 2:
        currentWidget = TheWayOfPayment();
    }
    notifyListeners();
  }
}
