import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';
import 'categories_model.dart';
part 'home_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class HomeModel extends Equatable {
  List<CategoriesModel>? categories;
  List<TripDetailsModel>? trips;

  HomeModel({this.categories, this.trips});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    HomeModel x = _$HomeModelFromJson(json);
    return HomeModel(
        categories: x.categories, trips: x.trips?.reversed.toList() ?? []);
  }

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);

  @override
  List<Object?> get props => [categories, trips];
}
