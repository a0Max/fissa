import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'user_data_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserData extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? countryCode;
  final int? isDriver;
  final String? driverType;
  final String? emailVerifiedAt;
  final String? password;
  final int? isActive;
  final String? lat;
  final String? lng;
  final String? rememberToken;
  final String? createdAt;
  final String? updatedAt;
  final int? isAvailable;

  UserData(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.countryCode,
      this.isDriver,
      this.driverType,
      this.emailVerifiedAt,
      this.password,
      this.isActive,
      this.lat,
      this.lng,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.isAvailable});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return _$UserDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  static Future<void> saveToken({required String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', token);
  }

  static Future<String?> get getToken async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2JhaGFnZHJnZmdmLmNvbS9maXNhYS9wdWJsaWMvYXBpL2xvZ2luIiwiaWF0IjoxNzI5MTAzNzc3LCJleHAiOjQ4Mzg1MTAzNzc3LCJuYmYiOjE3MjkxMDM3NzcsImp0aSI6IlpBV0JGVlk5cjNUY015RVoiLCJzdWIiOiIyIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.xGreDrJB3oIt_MOS7Gj42C9ki5oi6Ey6RvexA-hX_0U";
    return prefs.getString('userToken');
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        countryCode,
        isDriver,
        driverType,
        emailVerifiedAt,
        password,
        isActive,
        lat,
        lng,
        rememberToken,
        createdAt,
        updatedAt,
        isAvailable
      ];
}
