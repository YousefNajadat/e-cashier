// features/log_in/data/datasources/log_in_remote_data_source_impl.dart
import 'package:e_cashier/core/constant/api_routes.dart';
import 'package:e_cashier/core/network/api_response_model.dart';
import 'package:e_cashier/core/network/e_cashier_rest.dart';
import '../../domain/params/log_in_parameters.dart';
import 'i_log_in_remote_data_source.dart';
import 'log_in_remote_data_source.dart';

// features/login/data/datasources/login_remote_data_source_impl.dart
class LogInRemoteDataSource implements ILogInRemoteDataSource {
  final ECashierRest eCashierRest;

  LogInRemoteDataSource(this.eCashierRest);

  @override
  Future<ApiResponse> login(LogInParameters parameters) async {
    return await eCashierRest.post(
      ApiRoutes.logInApi,
      data: parameters.toJson(),
    );
  }
}
