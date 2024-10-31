import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationService {
  Future<Position?> getCurrentLocation();
  Future<bool> askForPermissionIfNeeded();
  Future<BitmapDescriptor> getTheMarker({required String image});
}

class LocationServiceImpl implements LocationService {
  @override
  Future<bool> askForPermissionIfNeeded() {
    // TODO: implement askForPermissionIfNeeded
    throw UnimplementedError();
  }

  @override
  Future<Position?> getCurrentLocation() {
    // TODO: implement getCurrentLocation
    throw UnimplementedError();
  }

  @override
  Future<BitmapDescriptor> getTheMarker({required String image}) async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.5), image);
  }
}
