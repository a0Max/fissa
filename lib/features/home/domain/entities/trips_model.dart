import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'trips_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TripsModel extends Equatable {
  int? id;
  String? objectType;
  String? weight;
  String? status;
  String? from;
  String? to;

  TripsModel(
      {this.id, this.objectType, this.weight, this.status, this.from, this.to});

  factory TripsModel.fromJson(Map<String, dynamic> json) {
    return _$TripsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TripsModelToJson(this);

  @override
  List<Object?> get props => [id, objectType, weight, status, from, to];
}
