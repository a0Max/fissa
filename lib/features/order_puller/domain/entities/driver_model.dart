import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';

part 'driver_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DriverModel extends Equatable {
  int? id;
  String? name;
  String? phone;
  String? countryCode;
  int? isDriver;
  int? isActive;
  String? lat;
  String? lng;
  String? createdAt;
  String? updatedAt;
  int? isAvailable;
  String? otp;
  String? image;

  DriverModel(
      {this.id,
      this.name,
      this.phone,
      this.countryCode,
      this.isDriver,
      this.isActive,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt,
      this.isAvailable,
      this.otp,
      this.image});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    log('DriverModel:$json');

    return _$DriverModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        countryCode,
        isActive,
        isDriver,
        lat,
        lng,
        createdAt,
        updatedAt,
        isAvailable,
        otp,
        image
      ];
}
