import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import 'driver_model.dart';
import 'driver_review_model.dart';

part 'data_of_trip_puller_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DataOfTripePullerModel extends Equatable {
  TripDetailsModel? tripDetails;
  DriverReviewModel? driverReviews;
  DriverModel? driverId;

  DataOfTripePullerModel({this.tripDetails, this.driverReviews, this.driverId});

  factory DataOfTripePullerModel.fromJson(Map<String, dynamic> json) {
    return _$DataOfTripePullerModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataOfTripePullerModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [tripDetails, driverId, driverReviews];
}
