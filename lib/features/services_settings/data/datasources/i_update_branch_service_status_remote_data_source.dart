import '../../../../core/network/api_response_model.dart';
import '../../domain/params/services_settings_parameters.dart';
import '../../domain/params/update_branch_service_status_parameters.dart';

abstract class IUpdateBranchServiceStatusRemoteDataSource {
  Future<ApiResponse> updateBranchServiceStatus(
    UpdateBranchServiceStatusParameters parameters,
  );
}
