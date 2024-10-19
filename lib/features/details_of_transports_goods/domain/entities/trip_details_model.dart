import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trip_details_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TripDetailsModel extends Equatable {
  final int? passengerId;
  final String? typeId;
  final String? from;
  final String? fromLat;
  final String? fromLng;
  final String? to;
  final String? toLat;
  final String? toLng;
  final String? price;
  final String? isCash;
  final String? updatedAt;
  final String? createdAt;
  final String? status;

  final int? id;
  TripDetailsModel(
      {this.passengerId,
      this.typeId,
      this.from,
      this.fromLat,
      this.fromLng,
      this.to,
      this.status,
      this.toLat,
      this.toLng,
      this.price,
      this.isCash,
      this.updatedAt,
      this.createdAt,
      this.id});

  factory TripDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$TripDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TripDetailsModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        passengerId,
        typeId,
        from,
        fromLat,
        fromLng,
        to,
        toLat,
        toLng,
        price,
        isCash,
        updatedAt,
        createdAt,
        id
      ];
}
