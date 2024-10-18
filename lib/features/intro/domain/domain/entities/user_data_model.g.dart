// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: (json['id'] as num?)?.toInt(),
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      countryCode: json['country_code'] as String?,
      isDriver: (json['is_driver'] as num?)?.toInt(),
      driverType: json['driver_type'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      password: json['password'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      rememberToken: json['remember_token'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isAvailable: (json['is_available'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'phone': instance.phone,
      'country_code': instance.countryCode,
      'is_driver': instance.isDriver,
      'driver_type': instance.driverType,
      'email_verified_at': instance.emailVerifiedAt,
      'password': instance.password,
      'is_active': instance.isActive,
      'lat': instance.lat,
      'lng': instance.lng,
      'remember_token': instance.rememberToken,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_available': instance.isAvailable,
    };
