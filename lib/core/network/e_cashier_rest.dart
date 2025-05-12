import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_cashier/core/network/request_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart'
    show PrettyDioLogger;
import '../constant/api_routes.dart';
import '../data/local/storage_helper.dart';
import 'api_response_model.dart';
import 'i_e_cashier_rest.dart';

class ECashierRest implements IECashierRest {
  final Dio _dio = Dio();
  final bool enableLog;

  final Map<String, dynamic> _baseHeaders = {
    'Access-Control-Allow-Origin': "*",
    'Content-Type': 'application/json',
    "Access-Control-Allow-Credentials": true,
  };

  Future<String> _getIpAddress() async {
    try {
      final interfaces = await NetworkInterface.list();
      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (!addr.isLoopback && addr.type == InternetAddressType.IPv4) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      developer.log('Error getting IP: $e');
    }
    return '127.0.0.1'; // Fallback
  }

  Future<void> _updateKioskHeaders() async {
    try {
      final ipAddress = await _getIpAddress();
      _baseHeaders['X-Kiosk-Identifier'] = ipAddress;
      _dio.options.headers = _baseHeaders;
    } catch (e) {
      developer.log('Failed to get IP address: $e');
      _baseHeaders['X-Kiosk-Identifier'] = 'unknown';
    }
  }

  ECashierRest({this.enableLog = true}) {
    _dio.options.baseUrl = ApiRoutes.baseUrl;

    // Initialize IP headers
    _updateKioskHeaders();
    _dio.options.headers = _baseHeaders;

    _dio.interceptors.clear();
    if (enableLog) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: kDebugMode,
          requestBody: kDebugMode,
          responseHeader: kDebugMode,
          responseBody: kDebugMode,
          error: true,
          showCUrl: true,
          canShowLog: true,
          logPrint: (logs) => developer.log(logs.toString()),
        ),
      );
    }
  }

  @override
  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  }) async {
    try {
      final requestData = await _prepareRequest(
        data: null,
        headers: headers,
        queryParameters: queryParameters,
        userToken: userToken,
      );

      final response = await _dio.get(
        url,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ApiResponse> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  }) async {
    try {
      final requestData = await _prepareRequest(
        data: data,
        headers: headers,
        queryParameters: queryParameters,
        userToken: userToken,
      );

      final response = await _dio.post(
        url,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ApiResponse> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  }) async {
    try {
      final requestData = await _prepareRequest(
        data: data,
        headers: headers,
        queryParameters: queryParameters,
        userToken: userToken,
      );

      final response = await _dio.put(
        url,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ApiResponse> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  }) async {
    try {
      final requestData = await _prepareRequest(
        data: data,
        headers: headers,
        queryParameters: queryParameters,
        userToken: userToken,
      );

      final response = await _dio.delete(
        url,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ApiResponse> download(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  }) async {
    try {
      final requestData = await _prepareRequest(
        data: null,
        headers: headers,
        queryParameters: queryParameters,
        userToken: userToken,
      );

      final response = await _dio.get(
        url,
        options: Options(
          headers: requestData.headers,
          responseType: ResponseType.bytes,
        ),
        queryParameters: requestData.params,
      );

      return ApiResponse(success: true, data: response.data);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  Future<RequestData> _prepareRequest({
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  }) async {
    final requestHeaders = Map<String, dynamic>.from(headers ?? _baseHeaders);

    // Add common headers
    requestHeaders.addAll({
      'lang': await StorageHelper.getLang() ?? 'en',
      'DeviceDate': DateTime.now().toIso8601String(),
    });

    // Add authorization header if token exists
    final token = userToken ?? await StorageHelper.getAccessToken();
    if (token != null && token.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $token';
    }

    return RequestData(
      data: data,
      headers: requestHeaders,
      params: queryParameters ?? {},
    );
  }

  ApiResponse _handleResponse(Response response) {
    if (enableLog) {
      _logResponse(response);
    }

    if (response.data is Map) {
      return ApiResponse.fromJson(response.data);
    }

    return ApiResponse(
      success: response.statusCode! >= 200 && response.statusCode! < 300,
      data: response.data,
    );
  }

  ApiResponse _handleDioError(DioError e) {
    _logError(e);

    if (e.response != null) {
      if (e.response!.data is Map) {
        return ApiResponse.fromJson(e.response!.data);
      }

      return ApiResponse(
        success: false,
        message: e.message,
        errorCode: e.response?.statusCode.toString(),
        data: e.response?.data,
      );
    }

    return ApiResponse(success: false, message: e.message, errorCode: '500');
  }

  void _logResponse(Response response) {
    final trace = '''
════════════════════════════════════════ 
╔╣ Dio [RESPONSE] info ==> 
╟ BASE_URL: ${response.requestOptions.baseUrl}
╟ PATH: ${response.requestOptions.path}
╟ Method: ${response.requestOptions.method}
╟ Params: ${response.requestOptions.queryParameters}
╟ Body: ${response.requestOptions.data}
╟ Header: ${response.requestOptions.headers}
╟ statusCode: ${response.statusCode}
╟ RESPONSE: ${jsonEncode(response.data)}
╚ [END] ════════════════════════════════════════╝
''';
    developer.log(trace);
  }

  void _logError(DioError e) {
    final trace = '''
════════════════════════════════════════ 
╔╣ Dio [ERROR] info ==> 
╟ BASE_URL: ${e.requestOptions.baseUrl}
╟ PATH: ${e.requestOptions.path}
╟ Method: ${e.requestOptions.method}
╟ Params: ${e.requestOptions.queryParameters}
╟ Body: ${e.requestOptions.data}
╟ Header: ${e.requestOptions.headers}
╟ statusCode: ${e.response?.statusCode}
╟ RESPONSE: ${e.response?.data}
╟ stackTrace: ${e.stackTrace}
╚ [END] ════════════════════════════════════════╝
''';
    developer.log(trace);
  }
}
