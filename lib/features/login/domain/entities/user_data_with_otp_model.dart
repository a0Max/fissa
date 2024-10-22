import 'package:equatable/equatable.dart';
import 'package:fisaa/features/intro/domain/entities/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_data_with_otp_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserDataWithOtpModel extends Equatable {
  num? otp;
  List<String>? requiredFields;
  UserData? usr;

  UserDataWithOtpModel({this.otp, this.usr, this.requiredFields});

  factory UserDataWithOtpModel.fromJson(Map<String, dynamic> json) {
    return _$UserDataWithOtpModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserDataWithOtpModelToJson(this);

  @override
  List<Object?> get props => [otp, usr, requiredFields];
}
