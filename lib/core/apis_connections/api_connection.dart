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
import '../error/exceptions.dart';

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
  String locationInformationEndPoint = "place/textsearch/json";
  String homeEndPoint = "homeScr";
  String getStuffTypesEndPoint = "get-stuff-types";
  String userEndPoint = "user";
  String createTripsEndPoint = "trips/create";
  String getThePriceOfTripTripsEndPoint = "trips/trip/price";
  String authLoginEndPoint = "auth/login";
  String authLoginValidateOtpEndPoint = "auth/login-validate-otp";
  String authUpdateProfileEndPoint = "auth/update-profile";
  String tripHistoryEndPoint = "trip-history";
  String getNotifications = "auth/get-notifications";
  String logoutEndPoint = "auth/logout";
  String cancelTheTripsEndPoint({required int tripId}) {
    return "trips/$tripId/cancel-current";
  }

  String rateTheTripsEndPoint({required int tripId}) {
    return "trips/$tripId/review";
  }

////////////////////////////////////////////////////////////////////////////

  // Validating Request.
  bool validResponse(di.Response response) {
    int? statusCode = response.statusCode;
    bool? result;
    try {
      result = response.data['result'];
    } catch (e) {
      result = true;
    }
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
    String? token = await _getUserToken();
    // String? token = await '49|Be3S6k5AY53xzLOTFK2tsgiLmovB1Rc0eBvUkJet51c65cde';
    try {
      di.Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: dioOptions(token),
      );

      print('response:${response.data}');
      if (validResponse(response)) {
        return response;
      } else {
        throw MessageException(message: response.data['msg']);
      }
    } on DioException catch (dioError) {
      print('response:${dioError.response?.data}');
      if (dioError.response != null && dioError.response?.data != null) {
        throw MessageException(message: dioError.response!.data['msg']);
      }
      throw ServerException();
    }
  }

  Future<di.Response<dynamic>> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, String?>? headers,
  }) async {
    String? token = await _getUserToken();

    // try {
    final response = await dio.post(
      url,
      queryParameters: queryParameters,
      data: data,
      options: dioOptions(token),
    );

    if (validResponse(response)) {
      return response;
    } else {
      throw MessageException(message: response.data['msg']);
    }
    // } on DioException catch (dioError) {
    //   print("DioException:${dioError.response}");
    //   if (dioError.response != null && dioError.response?.data != null) {
    //     throw MessageException(message: dioError.response!.data['msg']);
    //   }
    //   throw ServerException();
    // }
  }

  // TODO DIO uploadImage
  Future<http.Response> uploadImage({
    required String url,
    File? filePath,
    Map<String, String>? queryParameters,
    Map<String, String>? data,
    Map<String, String?>? headers,
  }) async {
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

  Options dioOptions(String? token, [Map<String, String?>? headers]) {
    return Options(
      contentType: 'application/json',
      headers: {
        ...headers ?? apiHeaders,
        'Authorization': 'Bearer $token',
      },
    );
  }
}
