import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'matched_substrings_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MatchedSubstringsModel extends Equatable {
  int? length;
  int? offset;

  MatchedSubstringsModel({this.length, this.offset});

  factory MatchedSubstringsModel.fromJson(Map<String, dynamic> json) {
    return _$MatchedSubstringsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MatchedSubstringsModelToJson(this);

  @override
  List<Object?> get props => [length, offset];
}
