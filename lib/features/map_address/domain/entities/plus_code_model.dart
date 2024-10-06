import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';
part 'plus_code_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PlusCodeModel extends Equatable {
  String? compoundCode;
  String? globalCode;

  PlusCodeModel({this.compoundCode, this.globalCode});

  factory PlusCodeModel.fromJson(Map<String, dynamic> json) {
    return _$PlusCodeModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$PlusCodeModelToJson(this);

  @override
  List<Object?> get props => [compoundCode, globalCode];
}
