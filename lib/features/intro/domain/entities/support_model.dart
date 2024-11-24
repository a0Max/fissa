import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'support_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SupportModel {
  Terms? terms;

  SupportModel({this.terms});

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return _$SupportModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$SupportModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Terms {
  List<TermsModel>? terms;
  List<PrivacyModel>? privacy;

  Terms({this.terms, this.privacy});

  factory Terms.fromJson(Map<String, dynamic> json) {
    return _$TermsFromJson(json);
  }
  Map<String, dynamic> toJson() => _$TermsToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TermsModel {
  int? id;
  String? terms;
  int? part;

  TermsModel({this.id, this.terms, this.part});

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return _$TermsModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$TermsModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PrivacyModel {
  int? id;
  String? privacy;
  int? part;

  PrivacyModel({this.id, this.privacy, this.part});

  factory PrivacyModel.fromJson(Map<String, dynamic> json) {
    return _$PrivacyModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$PrivacyModelToJson(this);
}
