// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_of_good_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeOfGoodModel _$TypeOfGoodModelFromJson(Map<String, dynamic> json) =>
    TypeOfGoodModel(
      image: json['image'] as String?,
      title: json['title'] as String?,
      goodKey: (json['good_key'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TypeOfGoodModelToJson(TypeOfGoodModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'good_key': instance.goodKey,
    };
