import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'terms_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TermsModel extends Equatable {
  int? offset;
  String? value;

  TermsModel({this.offset, this.value});

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return _$TermsModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$TermsModelToJson(this);

  @override
  List<Object?> get props => [offset, value];
}
