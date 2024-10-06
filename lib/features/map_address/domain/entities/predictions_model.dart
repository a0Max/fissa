import 'package:equatable/equatable.dart';
import 'package:fisaa/features/map_address/domain/entities/location_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'geometry_model.dart';
import 'plus_code_model.dart';
part 'predictions_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PredictionsModel extends Equatable {
  String? businessStatus;
  String? formattedAddress;
  GeometryModel? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  String? placeId;
  PlusCodeModel? plusCode;
  double? rating;
  String? reference;
  List<String>? types;
  int? userRatingsTotal;
  int? priceLevel;

  PredictionsModel(
      {this.businessStatus,
      this.formattedAddress,
      this.geometry,
      this.icon,
      this.iconBackgroundColor,
      this.iconMaskBaseUri,
      this.name,
      this.placeId,
      this.plusCode,
      this.rating,
      this.reference,
      this.types,
      this.userRatingsTotal,
      this.priceLevel});

  factory PredictionsModel.fromJson(Map<String, dynamic> json) {
    return _$PredictionsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PredictionsModelToJson(this);

  @override
  List<Object?> get props => [
        businessStatus,
        formattedAddress,
        priceLevel,
        placeId,
        rating,
        userRatingsTotal,
        reference,
        plusCode,
        geometry,
        name,
        iconMaskBaseUri,
        iconBackgroundColor,
        icon,
        types
      ];
}