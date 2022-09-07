import 'dart:convert';

import 'package:dio/dio.dart';

import 'interseptor_service.dart';

class NetworkService {

  /// Base Url */
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "http://10.10.6.66:4543";
  static String SERVER_PRODUCTION = "http://10.10.6.66:4543";

  static String get baseApiUrl {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /// Apis */
  static String API_SEND_CODE = "/api/v1/web/free/sendCode";
  static String APi_TAKE_USER_INFO = "/api/v1/mobile/user";
  /// Headers */
  static Map<String, String> get headers {
    Map<String, String> headers = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Accept-Version': 'v1',
    };
    return headers;
  }

  static Map<String, String> get headersMultipart {
    Map<String, String> headers = {
      'Accept': '*/*',
      'Content-Type': 'multipart/form-data',
      'Accept-Version': 'v1',
    };
    return headers;
  }
  /// BaseOptions */
  static final BaseOptions _baseDioOptions = BaseOptions(
    baseUrl: baseApiUrl,
    headers: headers,
    connectTimeout: 40000,
    receiveTimeout: 40000,
    contentType: 'application/json',
    responseType: ResponseType.json,
  );

  static final BaseOptions _baseDioOptionsMultipart = BaseOptions(
    baseUrl: baseApiUrl,
    headers: headersMultipart,
    connectTimeout: 40000,
    receiveTimeout: 40000,
    contentType: 'multipart/form-data',
    responseType: ResponseType.bytes,
  );

  static final Dio _dio = Dio(_baseDioOptions)..interceptors.add(DioInterceptor());

  /* Dio Requests */
  static Future<Map<String, dynamic>?> GET(String api, Map<String, dynamic> params) async {
    Response response = await _dio.get(api, queryParameters: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> POST(String api, Map<String, dynamic> body) async {
    Response response = await _dio.post(api, data: jsonEncode(body) );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }

  static Future<String?> MULTIPART(String api, String path) async {
    _dio.options = _baseDioOptionsMultipart;
    Response response = await _dio.post(api, data: {
      "file" : await MultipartFile.fromFile(path, filename: "test")
    });
    _dio.options = _baseDioOptions;
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> PUT(String api, Map<String, dynamic> params) async {
    Response response = await _dio.put(api, data: params); // http or https
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }
  static Future<String?> PATCH(String api, Map<String, dynamic> params) async {
    Response response = await _dio.patch(api, data: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }
  static Future<dynamic> DELETE(String api, Map<String, dynamic> params) async {
    Response response = await _dio.delete(api, data: params);
    if (response.statusCode == 200 || response.statusCode == 201||response.statusCode == 204) {
      return response.data;
    }
    return null;
  }


/// Dio Query Params */



/// Dio Body */
}