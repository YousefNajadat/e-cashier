import 'package:dartz/dartz.dart';

import '../entities/services_settings_entity.dart';
import '../entities/update_branch_service_status_entity.dart';
import '../params/services_settings_parameters.dart';
import '../params/update_branch_service_status_parameters.dart';
abstract class IUpdateBranchServiceStatusRepository {
  Future<Either<String, UpdateBranchServiceStatusEntity>> updateBranchServiceStatus(
      UpdateBranchServiceStatusParameters parameters,
  );
}
