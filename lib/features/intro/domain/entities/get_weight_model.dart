import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_weight_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetWeightModel extends Equatable {
  final int? id;
  final String? weight;
  final num? price;

  GetWeightModel({this.id, this.weight, this.price});

  factory GetWeightModel.fromJson(Map<String, dynamic> json) {
    return _$GetWeightModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetWeightModelToJson(this);

  @override
  List<Object?> get props => [id, weight, price];
}
