import 'package:equatable/equatable.dart';
import 'package:fisaa/features/map_address/domain/entities/terms_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'matched_substrings_model.dart';
part 'predictions_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PredictionsModel extends Equatable {
  String? description;
  List<MatchedSubstringsModel>? matchedSubstrings;
  String? placeId;
  String? reference;
  MatchedSubstringsModel? structuredFormatting;
  List<TermsModel>? terms;
  List<String>? types;

  PredictionsModel(
      {this.description,
      this.matchedSubstrings,
      this.placeId,
      this.reference,
      this.structuredFormatting,
      this.terms,
      this.types});

  factory PredictionsModel.fromJson(Map<String, dynamic> json) {
    return _$PredictionsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PredictionsModelToJson(this);

  @override
  List<Object?> get props => [
        description,
        matchedSubstrings,
        placeId,
        reference,
        structuredFormatting,
        terms,
        types
      ];
}
