import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as di;
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../features/intro/domain/entities/user_data_model.dart';

class MainApiConnection {
  //Singleton
  MainApiConnection() {
    // Attach Interceptors.
    if (kDebugMode) dio.interceptors.add(_logger);
  }

  // static final ApiProvider instance = ApiProvider._();

  // Http Client
  final Dio dio = Dio();

  // Logger
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    error: true,
  );

  // Performance Interceptor

  // Headers
  static const Map<String, dynamic> apiHeaders = <String, dynamic>{
    'Accept': 'application/json'
  };

  ////////////////////////////// END POINTS ///////////////////////////////////
  String postLoginEndPoint = "auth/login";

////////////////////////////////////////////////////////////////////////////

  // Validating Request.
  bool validResponse(di.Response response) {
    int? statusCode = response.statusCode;
    bool? result = response.data['status'];
    if (statusCode == null || result == false) {
      return false;
    } else {
      return (statusCode >= 200 && statusCode < 300);
    }
  }
////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////// UTILS /////////////////////////////////////

  static Future<String> _getAppLanguage() async {
    return 'ar';
  }

  Future<String?> _getUserToken() async => await UserData.getToken;

  Future<di.Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    String language = await _getAppLanguage();
    String? token = await _getUserToken();

    di.Response response = await dio.get(
      url,
      queryParameters: queryParameters,
      options: dioOptions(language, token),
    );

    if (validResponse(response)) {
      return response;
    } else {
      throw response;
    }
  }

  Future<di.Response<dynamic>> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, String?>? headers,
  }) async {
    String language = await _getAppLanguage();
    String? token = await _getUserToken();

    final response = await dio.post(
      url,
      queryParameters: queryParameters,
      data: data,
      options: dioOptions(language, token),
    );
    if (validResponse(response)) {
      return response;
    } else {
      throw response;
    }
  }

  // TODO DIO uploadImage
  Future<http.Response> uploadImage({
    required String url,
    File? filePath,
    Map<String, String>? queryParameters,
    Map<String, String>? data,
    Map<String, String?>? headers,
  }) async {
    String language = await _getAppLanguage();
    String? token = await _getUserToken();
    var multipartFile;
    var stream;
    var length;
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );
    request.headers['AUTHORIZATION'] = 'Bearer ${token!}';
    request.headers['Accept'] = "application/json";
    data?.forEach((key, value) {
      request.fields[key] = value;
    });
    if (filePath != null) {
      stream = new http.ByteStream(DelegatingStream.typed(filePath.openRead()));
      length = await filePath.length();
      multipartFile = new http.MultipartFile('photo', stream, length,
          filename: basename(filePath.path));
      request.files.add(multipartFile);
    }
    StreamedResponse response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    var bodyData = json.decode(res.body);
    if (bodyData['result'] != null && res.statusCode == 200) {
      return res;
    } else {
      throw res;
    }
  }

  Options dioOptions(String language, String? token,
      [Map<String, String?>? headers]) {
    return Options(
      // contentType: 'application/json',
      headers: {
        ...headers ?? apiHeaders,
        'Authorization': 'Bearer $token',
      },
    );
  }
}
