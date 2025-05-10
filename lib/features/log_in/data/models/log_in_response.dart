// features/login/data/model/login_response.dart
class LoginResponse {
  final String accessToken;
  final LoginPermissionsResponse permissions;

  LoginResponse({required this.accessToken, required this.permissions});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    accessToken: json["accessToken"] ?? "",
    permissions: LoginPermissionsResponse.fromJson(json["permissions"] ?? {}),
  );
}

class LoginPermissionsResponse {
  final bool accessLogOut;

  LoginPermissionsResponse({required this.accessLogOut});

  factory LoginPermissionsResponse.fromJson(Map<String, dynamic> json) =>
      LoginPermissionsResponse(accessLogOut: json["accessLogOut"] ?? false);
}
