import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'categories_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CategoriesModel extends Equatable {
  int? id;
  String? title;
  String? image;
  String? shortTitle;
  String? tripType;
  int? isDiscount;
  int? isActive;
  int? discount;
  int? forceUserDiscount;

  CategoriesModel(
      {this.id,
      this.title,
      this.shortTitle,
      this.tripType,
      this.isDiscount,
      this.image,
      this.isActive,
      this.discount,
      this.forceUserDiscount});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return _$CategoriesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        tripType,
        shortTitle,
        isDiscount,
        isActive,
        discount,
        forceUserDiscount
      ];
}
