import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';
part 'viewport_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ViewportModel extends Equatable {
  LocationModel? northeast;
  LocationModel? southwest;

  ViewportModel({this.northeast, this.southwest});

  factory ViewportModel.fromJson(Map<String, dynamic> json) {
    return _$ViewportModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ViewportModelToJson(this);

  @override
  List<Object?> get props => [northeast, southwest];
}
