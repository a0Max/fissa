import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'categories_model.dart';
import 'trips_model.dart';
part 'home_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class HomeModel extends Equatable {
  List<CategoriesModel>? categories;
  List<TripsModel>? trips;

  HomeModel({this.categories, this.trips});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return _$HomeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);

  @override
  List<Object?> get props => [categories, trips];
}
