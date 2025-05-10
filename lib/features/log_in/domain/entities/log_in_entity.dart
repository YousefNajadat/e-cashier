// features/log_in/domain/entities/log_in_entity.dart
import '../../data/models/log_in_response.dart';

class LogInEntity {
  final String accessToken;
  final Permissions permissions;

  LogInEntity({
    required this.accessToken,
    required this.permissions,
  });

  factory LogInEntity.fromResponse(LoginResponse response) => LogInEntity(
    accessToken: response.accessToken,
    permissions: Permissions(
      accessLogOut: response.permissions.accessLogOut,
    ),
  );
}

class Permissions {
  final bool accessLogOut;

  Permissions({
    required this.accessLogOut,
  });
}
