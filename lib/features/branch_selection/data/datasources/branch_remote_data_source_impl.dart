import 'package:e_cashier/core/network/api_response_model.dart';
import '../../../../core/constant/api_routes.dart';
import '../../../../core/network/e_cashier_rest.dart';
import 'branch_remote_data_source.dart';

// features/Branch/data/datasources/Branch_remote_data_source_impl.dart
class BranchRemoteDataSource implements IBranchRemoteDataSource {
  final ECashierRest eCashierRest;

  BranchRemoteDataSource(this.eCashierRest);

  @override
  Future<ApiResponse> getBranch() async {
    return await eCashierRest.get(ApiRoutes.getBranch);
  }
}
