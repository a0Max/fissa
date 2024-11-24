import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_stuff_types_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetStuffTypesModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;

  GetStuffTypesModel({this.id, this.name, this.image});

  factory GetStuffTypesModel.fromJson(Map<String, dynamic> json) {
    return _$GetStuffTypesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetStuffTypesModelToJson(this);

  @override
  List<Object?> get props => [id, name, image];
}
