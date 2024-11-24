import 'package:equatable/equatable.dart';
import 'package:fisaa/features/intro/domain/entities/support_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../home/domain/entities/categories_model.dart';
import 'get_stuff_types_model.dart';
import 'get_weight_model.dart';
import 'get_workers_model.dart';
part 'main_app_required.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MainAppRequiredModel extends Equatable {
  final List<GetStuffTypesModel>? types;
  final List<GetWorkersModel>? workers;
  final List<GetWeightModel>? weight;
  final List<CategoriesModel>? categories;
  final SupportModel? support;
  MainAppRequiredModel(
      {this.types, this.workers, this.weight, this.categories, this.support});

  factory MainAppRequiredModel.fromJson(Map<String, dynamic> json) {
    print('json00:$json');
    return _$MainAppRequiredModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MainAppRequiredModelToJson(this);

  @override
  List<Object?> get props => [types, workers, weight, categories, support];
}
