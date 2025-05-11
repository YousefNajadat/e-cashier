import 'package:dartz/dartz.dart';

import '../entities/update_branch_service_status_entity.dart';
import '../params/update_branch_service_status_parameters.dart';
import '../repositories/i_update_branch_service_status_repository.dart';

class UpdateBranchServiceStatusUseCase {
  final IUpdateBranchServiceStatusRepository repository;

  UpdateBranchServiceStatusUseCase({required this.repository});

  Future<Either<String, UpdateBranchServiceStatusEntity>> call(
    UpdateBranchServiceStatusParameters parameters,
  ) async {
    return await repository.updateBranchServiceStatus(parameters);
  }
}
