import 'package:equatable/equatable.dart';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/enums/state_of_ride.dart';

part 'current_trip_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CurrentTripModel extends Equatable {
  int? tripId;
  dynamic? lat;
  dynamic? lng;
  int? etaMinutes;
  String? status;

  CurrentTripModel(
      {this.tripId, this.lat, this.lng, this.etaMinutes, this.status});

  factory CurrentTripModel.fromJson(Map<String, dynamic> json) {
    return _$CurrentTripModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CurrentTripModelToJson(this);

  StateOfRide getTheStateOfTrip() {
    return TypeExtensionOfStateOfRide.getState(textDataBase: status ?? '');
  }

  @override
  List<Object?> get props => [tripId, lat, lng, etaMinutes, status];
}
