import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../intro/domain/entities/user_data_model.dart';
import '../../../order_puller/domain/entities/driver_model.dart';

part 'trip_details_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TripDetailsModel extends Equatable {
  final int? passengerId;
  final String? from;
  final String? stuffTypeName;
  final String? weightName;
  final String? tripTime;
  final String? stuffTypeImage;
  final String? workerName;
  final String? typeName;
  final String? paymentBy;
  final String? receiverPhone;
  final String? receiverName;
  final String? senderPhone;
  final String? senderName;
  final String? weight;
  final String? fromLat;
  final String? fromLng;
  final String? to;
  final String? toLat;
  final String? toLng;
  dynamic price;
  dynamic typeId;
  dynamic isCash;
  final String? updatedAt;
  final String? createdAt;
  final String? status;
  final int? id;
  final DriverModel? driver;
  final UserData? passenger;

  TripDetailsModel(
      {this.passengerId,
      this.stuffTypeImage,
      this.weightName,
      this.driver,
      this.passenger,
      this.workerName,
      this.typeName,
      this.stuffTypeName,
      this.from,
      this.fromLat,
      this.fromLng,
      this.to,
      this.weight,
      this.status,
      this.toLat,
      this.toLng,
      this.price,
      this.isCash,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.tripTime,
      this.paymentBy,
      this.receiverName,
      this.receiverPhone,
      this.senderName,
      this.senderPhone});

  factory TripDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$TripDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TripDetailsModelToJson(this);

  String getTheDateFormat() {
    try {
      if (createdAt == null) return '';
      DateTime date = DateTime.parse(createdAt!);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return '';
    }
  }

  @override
  List<Object?> get props => [
        passengerId,
        stuffTypeImage,
        weightName,
        workerName,
        passenger,
        typeName,
        stuffTypeName,
        from,
        fromLat,
        fromLng,
        driver,
        to,
        weight,
        status,
        toLat,
        toLng,
        price,
        isCash,
        updatedAt,
        createdAt,
        id,
        tripTime,
        paymentBy,
        receiverName,
        receiverPhone,
        senderName,
        senderPhone,
      ];
}
