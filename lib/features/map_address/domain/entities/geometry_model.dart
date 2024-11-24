import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';
import 'viewport_model.dart';
part 'geometry_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GeometryModel extends Equatable {
  LocationModel? location;
  ViewportModel? viewport;

  GeometryModel({this.location, this.viewport});

  factory GeometryModel.fromJson(Map<String, dynamic> json) {
    return _$GeometryModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GeometryModelToJson(this);

  @override
  List<Object?> get props => [location, viewport];
}
