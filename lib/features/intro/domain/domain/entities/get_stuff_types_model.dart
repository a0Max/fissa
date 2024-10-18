import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'get_stuff_types_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetStuffTypesModel extends Equatable {
  final int? id;
  final String? name;

  GetStuffTypesModel({this.id, this.name});

  factory GetStuffTypesModel.fromJson(Map<String, dynamic> json) {
    return _$GetStuffTypesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetStuffTypesModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
