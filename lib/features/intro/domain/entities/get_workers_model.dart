import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_workers_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetWorkersModel extends Equatable {
  final int? id;
  final String? count;
  final num? price;

  GetWorkersModel({this.id, this.count, this.price});

  factory GetWorkersModel.fromJson(Map<String, dynamic> json) {
    return _$GetWorkersModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetWorkersModelToJson(this);

  @override
  List<Object?> get props => [id, count, price];
}
