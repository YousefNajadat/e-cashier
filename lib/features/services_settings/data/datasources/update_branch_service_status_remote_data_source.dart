import 'package:e_cashier/core/network/api_response_model.dart';

import 'package:e_cashier/features/services_settings/domain/params/services_settings_parameters.dart';
import 'package:e_cashier/features/services_settings/domain/params/update_branch_service_status_parameters.dart';

import '../../../../core/constant/api_routes.dart';
import '../../../../core/network/e_cashier_rest.dart';
import 'i_services_settings_remote_data_source.dart';
import 'i_update_branch_service_status_remote_data_source.dart';

class UpdateBranchServiceStatusRemoteDataSource
    implements IUpdateBranchServiceStatusRemoteDataSource {
  final ECashierRest eCashierRest;

  UpdateBranchServiceStatusRemoteDataSource(this.eCashierRest);

  @override
  Future<ApiResponse> updateBranchServiceStatus(
    UpdateBranchServiceStatusParameters parameters,
  ) async {
    return await eCashierRest.put(
      ApiRoutes.updateBranchServiceStatus,
      data: parameters.toJson(),
    );
  }
}
