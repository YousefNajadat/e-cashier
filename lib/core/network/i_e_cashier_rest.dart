import 'api_response_model.dart';

abstract class IECashierRest {
  Future<ApiResponse> get(
      String url, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        String? userToken,
      });

  Future<ApiResponse> post(
      String url, {
        dynamic data,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        String? userToken,
      });

  Future<ApiResponse> put(
      String url, {
        dynamic data,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        String? userToken,
      });

  Future<ApiResponse> delete(
      String url, {
        dynamic data,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        String? userToken,
      });

  Future<ApiResponse> download(
      String url, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        String? userToken,
      });
}