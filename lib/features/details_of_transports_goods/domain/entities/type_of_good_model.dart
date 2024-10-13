import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'type_of_good_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TypeOfGoodModel extends Equatable {
  final String? image;
  final String? title;
  final int? goodKey;

  TypeOfGoodModel({this.image, this.title, this.goodKey});

  factory TypeOfGoodModel.fromJson(Map<String, dynamic> json) {
    return _$TypeOfGoodModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TypeOfGoodModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [goodKey, image, title];
}
