import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import 'driver_model.dart';
import 'driver_review_model.dart';

part 'car_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CarModel extends Equatable {
  int? id;
  String? plateNum;
  int? driverId;

  CarModel({this.id, this.plateNum, this.driverId});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return _$CarModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CarModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [id, driverId, plateNum];
}
