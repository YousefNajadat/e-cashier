import 'package:e_cashier/core/network/api_response_model.dart';

import '../../domain/params/log_in_parameters.dart';

// features/log_in/data/datasources/login_remote_data_source.dart
abstract class ILogInRemoteDataSource {
  Future<ApiResponse> login(LogInParameters parameters);
}
