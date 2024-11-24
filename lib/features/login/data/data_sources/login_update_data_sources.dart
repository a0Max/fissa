import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fisaa/features/intro/domain/entities/user_data_model.dart';
import 'package:quiver/strings.dart';

import '../../../../core/apis_connections/api_connection.dart';
import '../../../../core/connection.dart';
import '../../domain/entities/user_data_with_otp_model.dart';

abstract class DataSourceRemotelyOfLoginUpdateData {
  Future<UserDataWithOtpModel> loginRepository({required String phone});
  Future<bool> logOutRepository();
  Future<UserDataWithOtpModel> addRequiredDataRepository(
      {required String name, required String? email});
  Future<UserDataWithOtpModel> checkOtpRepository(
      {required String phone, required String otp});
  Future<UserData> updateUserDataRepository(
      {required String name, required String email, File? image});
}

class DataSourceRemotelyOfLoginUpdateImpl
    implements DataSourceRemotelyOfLoginUpdateData {
  final MainApiConnection dio;

  DataSourceRemotelyOfLoginUpdateImpl({required this.dio});

  @override
  Future<UserDataWithOtpModel> addRequiredDataRepository(
      {required String name, required String? email}) async {
    final response = await dio.post(
        url: '${Connection.baseURL}${dio.authUpdateProfileEndPoint}',
        queryParameters: {'name': name, 'email': email});
    if (dio.validResponse(response)) {
      return UserDataWithOtpModel.fromJson(response.data['data']);
    } else {
      throw response.data['msg'];
    }
  }

  @override
  Future<UserDataWithOtpModel> checkOtpRepository(
      {required String phone, required String otp}) async {
    final response = await dio.post(
        url: '${Connection.baseURL}${dio.authLoginValidateOtpEndPoint}',
        queryParameters: {'phone': phone, 'country_code': "+218", 'otp': otp});
    if (dio.validResponse(response)) {
      await UserData.saveToken(token: response.data['data']['token']);
      return UserDataWithOtpModel.fromJson(response.data['data']);
    } else {
      throw response.data['msg'];
    }
  }

  @override
  Future<UserDataWithOtpModel> loginRepository({required String phone}) async {
    final response = await dio.post(
        url: '${Connection.baseURL}${dio.authLoginEndPoint}',
        queryParameters: {'phone': phone, 'country_code': "+218"});
    if (dio.validResponse(response)) {
      return UserDataWithOtpModel.fromJson(response.data['data']);
    } else {
      throw response.data['msg'];
    }
  }

  @override
  Future<UserData> updateUserDataRepository(
      {required String name, required String email, File? image}) async {
    FormData formData = FormData.fromMap({
      'name': name,
      if (email.isNotEmpty) 'email': email,
      if (image != null)
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
    });
    final response = await dio.post(
      url: '${Connection.baseURL}${dio.authUpdateProfileEndPoint}',
      data: formData,
    );
    if (dio.validResponse(response)) {
      return UserData.fromJson(response.data['data']['usr']);
    } else {
      throw response.data['msg'];
    }
  }

  @override
  Future<bool> logOutRepository() async {
    await UserData.removeToken;

    final response = await dio.post(
      url: '${Connection.baseURL}${dio.logoutEndPoint}',
    );
    if (dio.validResponse(response)) {
      return true;
    } else {
      throw response.data['msg'];
    }
  }
}
