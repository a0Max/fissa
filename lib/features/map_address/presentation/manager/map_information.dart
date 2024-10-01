import 'dart:async';

import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/main_map_informations.dart';

class MapInformation extends ChangeNotifier {
  MapInformation() {
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
}
