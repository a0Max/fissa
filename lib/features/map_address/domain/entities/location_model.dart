import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LocationModel extends Equatable {
  double? lat;
  double? lng;

  LocationModel({this.lat, this.lng});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return _$LocationModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  @override
  List<Object?> get props => [lat, lng];
}
