import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../details_of_transports_goods/domain/entities/trip_details_model.dart';

part 'driver_review_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DriverReviewModel extends Equatable {
  int? totalRating;
  int? ratingCount;
  int? averageRating;

  DriverReviewModel({this.totalRating, this.ratingCount, this.averageRating});

  factory DriverReviewModel.fromJson(Map<String, dynamic> json) {
    return _$DriverReviewModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DriverReviewModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [totalRating, ratingCount, averageRating];
}
