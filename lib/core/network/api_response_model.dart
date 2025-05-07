class ApiResponse {
  final dynamic data;
  final bool success;
  final String? message;
  final String? errorCode;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.errorCode,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json["success"] ?? false,
      message: json["message"],
      data: json["data"],
      errorCode: json["errorCode"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
    "errorCode": errorCode,
  };
}