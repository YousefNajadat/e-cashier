import '../../../../core/network/api_response_model.dart';

// features/branch_selection/data/datasources/branch_remote_data_source.dart
abstract class IBranchRemoteDataSource {
  Future<ApiResponse> getBranch();
}
