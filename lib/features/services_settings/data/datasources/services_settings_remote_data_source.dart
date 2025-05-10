import 'package:e_cashier/core/network/api_response_model.dart';

import 'package:e_cashier/features/services_settings/domain/params/services_settings_parameters.dart';

import '../../../../core/constant/api_routes.dart';
import '../../../../core/network/e_cashier_rest.dart';
import 'i_services_settings_remote_data_source.dart';

class ServicesSettingsRemoteDataSource
    implements IServicesSettingsRemoteDataSource {
  final ECashierRest eCashierRest;

  ServicesSettingsRemoteDataSource(this.eCashierRest);

  @override
  Future<ApiResponse> getServicesSettings(
    ServicesSettingsParameters parameters,
  ) async {
    return await eCashierRest.get(
      ApiRoutes.getSettingsBybranchId,
      queryParameters: parameters.toJson(),
    );
  }
}
