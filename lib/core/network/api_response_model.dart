import '../../features/log_in/data/models/log_in_response.dart';
import '../../features/log_in/domain/entities/log_in_entity.dart';

class ApiResponse {
  final dynamic data;
  final bool success;
  final String? message;
  final String? errorCode;
  final String? accessToken;
  final LoginPermissionsResponse? permissions;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.errorCode,
    this.accessToken,
    this.permissions,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json["success"] ?? false,
      message: json["message"],
      data: json["data"],
      errorCode: json["errorCode"],
      accessToken: json["accessToken"]??'',
      permissions: LoginPermissionsResponse.fromJson(json["permissions"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
    "errorCode": errorCode,
    "accessToken": accessToken,
    "permissions": permissions,
  };
}
