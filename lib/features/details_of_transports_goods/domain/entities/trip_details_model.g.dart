// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailsModel _$TripDetailsModelFromJson(Map<String, dynamic> json) =>
    TripDetailsModel(
      passengerId: (json['passenger_id'] as num?)?.toInt(),
      stuffTypeImage: json['stuff_type_image'] as String?,
      review: json['review'] == null
          ? null
          : DriverReviewModel.fromJson(json['review'] as Map<String, dynamic>),
      weightName: json['weight_name'] as String?,
      worker: json['worker'] == null
          ? null
          : GetWorkersModel.fromJson(json['worker'] as Map<String, dynamic>),
      driver: json['driver'] == null
          ? null
          : DriverModel.fromJson(json['driver'] as Map<String, dynamic>),
      passenger: json['passenger'] == null
          ? null
          : UserData.fromJson(json['passenger'] as Map<String, dynamic>),
      stuffType: json['stuff_type'] == null
          ? null
          : GetStuffTypesModel.fromJson(
              json['stuff_type'] as Map<String, dynamic>),
      workerName: json['worker_name'] as String?,
      typeName: json['type_name'] as String?,
      stuffTypeName: json['stuff_type_name'] as String?,
      from: json['from'] as String?,
      fromLat: json['from_lat'] as String?,
      fromLng: json['from_lng'] as String?,
      to: json['to'] as String?,
      weight: json['weight'] == null
          ? null
          : GetWeightModel.fromJson(json['weight'] as Map<String, dynamic>),
      status: json['status'] as String?,
      toLat: json['to_lat'] as String?,
      toLng: json['to_lng'] as String?,
      price: json['price'],
      isCash: json['is_cash'],
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
      tripTime: json['trip_time'] as String?,
      paymentBy: json['payment_by'] as String?,
      receiverName: json['receiver_name'] as String?,
      receiverPhone: json['receiver_phone'] as String?,
      senderName: json['sender_name'] as String?,
      senderPhone: json['sender_phone'] as String?,
    )..typeId = json['type_id'];

Map<String, dynamic> _$TripDetailsModelToJson(TripDetailsModel instance) =>
    <String, dynamic>{
      'passenger_id': instance.passengerId,
      'from': instance.from,
      'stuff_type_name': instance.stuffTypeName,
      'weight_name': instance.weightName,
      'trip_time': instance.tripTime,
      'stuff_type_image': instance.stuffTypeImage,
      'worker_name': instance.workerName,
      'type_name': instance.typeName,
      'payment_by': instance.paymentBy,
      'receiver_phone': instance.receiverPhone,
      'receiver_name': instance.receiverName,
      'sender_phone': instance.senderPhone,
      'sender_name': instance.senderName,
      'from_lat': instance.fromLat,
      'from_lng': instance.fromLng,
      'to': instance.to,
      'to_lat': instance.toLat,
      'to_lng': instance.toLng,
      'price': instance.price,
      'type_id': instance.typeId,
      'is_cash': instance.isCash,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'status': instance.status,
      'id': instance.id,
      'driver': instance.driver?.toJson(),
      'passenger': instance.passenger?.toJson(),
      'stuff_type': instance.stuffType?.toJson(),
      'review': instance.review?.toJson(),
      'weight': instance.weight?.toJson(),
      'worker': instance.worker?.toJson(),
    };
