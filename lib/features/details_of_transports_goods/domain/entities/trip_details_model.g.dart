// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailsModel _$TripDetailsModelFromJson(Map<String, dynamic> json) =>
    TripDetailsModel(
      passengerId: (json['passenger_id'] as num?)?.toInt(),
      typeId: json['type_id'] as String?,
      from: json['from'] as String?,
      fromLat: json['from_lat'] as String?,
      fromLng: json['from_lng'] as String?,
      to: json['to'] as String?,
      toLat: json['to_lat'] as String?,
      toLng: json['to_lng'] as String?,
      price: json['price'] as String?,
      isCash: json['is_cash'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TripDetailsModelToJson(TripDetailsModel instance) =>
    <String, dynamic>{
      'passenger_id': instance.passengerId,
      'type_id': instance.typeId,
      'from': instance.from,
      'from_lat': instance.fromLat,
      'from_lng': instance.fromLng,
      'to': instance.to,
      'to_lat': instance.toLat,
      'to_lng': instance.toLng,
      'price': instance.price,
      'is_cash': instance.isCash,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
    };
