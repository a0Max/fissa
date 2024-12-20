import 'package:equatable/equatable.dart';

import 'location_model.dart';

class FullLocationModel extends Equatable {
  LocationModel? startLocation;
  LocationModel? endLocation;
  String? startAddress;
  String? endAddress;

  FullLocationModel(
      {this.endAddress,
      this.startLocation,
      this.startAddress,
      this.endLocation});

  @override
  List<Object?> get props =>
      [endLocation, endAddress, startAddress, startLocation];
}
