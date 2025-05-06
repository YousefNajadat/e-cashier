import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart' show PrettyDioLogger;
import 'dart:developer';
import 'package:uuid/uuid.dart';
import '../constant/api_routes.dart';


abstract class ErrorCause {
  const ErrorCause();
}

class ApiError {
  const ApiError({this.message, this.cause, this.data});
  final dynamic data;
  final ErrorCause? cause;
  final String? message;
}

class ApiData {
  final int? statusCode;
  final dynamic data;

  const ApiData(this.data, this.statusCode);
}

class ApiService {
  final Dio dio = Dio();
  var uuid = Uuid();

  ApiService() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: kDebugMode,
        requestBody: kDebugMode,
        responseHeader: kDebugMode,
        responseBody: kDebugMode,
        error: true,
        showCUrl: true,
        canShowLog: true,
        logPrint: (logs) async {
          log(logs);
        },
      ),
    );
  }

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ',
      'Idempotency-Key': '${uuid.v4()}',
      'platform': Platform.operatingSystem,
    };
  }

  Future<Either<ApiError, dynamic>> handleResponse(
      Either<ApiError, dynamic> eitherResponse) async {
    return eitherResponse.fold(
          (apiError) {
        return Left(apiError);
      },
          (data) {
        return Right(data);
      },
    );
  }

  Future<Either<ApiError, dynamic>> catchSocketException(
      Function function) async {
    try {
      return await function();
    } on DioException catch (error) {
      var message = error.response;
      if (!message?.data.containsKey("message")) {
        return Left(ApiError(message: message?.data));
      } else {
        return Left(ApiError(message: message?.data['message']));
      }
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  Future<Either<ApiError, dynamic>> getReq(String url) async {
    final headers = _getHeaders();
    Response? response;

    try {
      response = await dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(ApiError(message: response.data['message']));
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 401);
      var message = error.response?.statusMessage ?? error.message;
      return Left(
          ApiError(message: message.toString(), data: error.response?.data));
    }
  }

  Future<Either<ApiError, dynamic>> postReq(String url, {dynamic body}) async {
    final headers = _getHeaders();

    try {
      Response response = await dio.post(ApiRoutes.baseUrl+url, data: body, options: Options(headers: headers));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data);
      } else {
        return Left(ApiError(message: response.data['message']));
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 401);
      var message = error.response?.data['message'] ?? error.message;
      return Left(ApiError(message: message.toString(), data: error.response?.data));
    }
  }

  Future<Either<ApiError, dynamic>> putReq(String url, {dynamic body}) async {
    final headers = _getHeaders();

    try {
      var response = await dio.put(url, data: body, options: Options(headers: headers));

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(ApiError(message: response.data['message']));
      }
    } on DioException catch (error) {
      var message = error.response?.data['message'] ?? error.message;
      return Left(ApiError(message: message.toString(), data: error.response?.data));
    }
  }

  Future<Either<ApiError, dynamic>> patchReq(String url, {dynamic body}) async {
    final headers = _getHeaders();

    try {
      var response = await dio.patch(url, data: body, options: Options(headers: headers));

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(ApiError(message: response.data['message']));
      }
    } on DioException catch (error) {
      var message = error.response?.data['message'] ?? error.message;
      return Left(ApiError(message: message.toString(), data: error.response?.data));
    }
  }

  Future<Either<ApiError, dynamic>> deleteReq(String url, {dynamic body}) async {
    final headers = _getHeaders();

    try {
      var response = await dio.delete(url, options: Options(headers: headers), data: body != null && body.isNotEmpty ? body : null);

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(ApiError(message: response.data['message'] ?? 'Unknown error'));
      }
    } on DioException catch (error) {
      var message = error.response?.data['message'] ?? error.message;
      return Left(ApiError(message: message.toString(), data: error.response?.data));
    }
  }
}

