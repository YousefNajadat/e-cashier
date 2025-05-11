import '../../data/models/services_settings_response.dart';
import '../../data/models/update_branch_service_status_response.dart';

class UpdateBranchServiceStatusEntity {
  bool? success;
  String? message;

  UpdateBranchServiceStatusEntity({this.success, this.message});

  factory UpdateBranchServiceStatusEntity.fromResponse(UpdateBranchServiceStatusResponse response) {
    return UpdateBranchServiceStatusEntity(
      success: response.success,
      message: response.message,
    );
  }
}
