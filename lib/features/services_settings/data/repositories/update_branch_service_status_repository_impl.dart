import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_cashier/features/services_settings/domain/entities/update_branch_service_status_entity.dart';
import 'package:e_cashier/features/services_settings/domain/params/update_branch_service_status_parameters.dart';

import '../../domain/entities/services_settings_entity.dart';
import '../../domain/params/services_settings_parameters.dart';
import '../../domain/repositories/i_services_settings_repository.dart';
import '../../domain/repositories/i_update_branch_service_status_repository.dart';
import '../datasources/i_services_settings_remote_data_source.dart';
import '../datasources/i_update_branch_service_status_remote_data_source.dart';
import '../models/services_settings_response.dart';
import '../models/update_branch_service_status_response.dart';

class UpdateBranchServiceStatusRepositoryImpl
    implements IUpdateBranchServiceStatusRepository {
  final IUpdateBranchServiceStatusRemoteDataSource remoteDataSource;

  UpdateBranchServiceStatusRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, UpdateBranchServiceStatusEntity>>
  updateBranchServiceStatus(
    UpdateBranchServiceStatusParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.updateBranchServiceStatus(
        parameters,
      );

      if (!response.success) {
        return Left(response.message ?? "ServicesSettings failed");
      }

      final updateBranchServiceStatusResponse =
          UpdateBranchServiceStatusResponse.fromJson(response.data);
      return Right(
        UpdateBranchServiceStatusEntity.fromResponse(
          updateBranchServiceStatusResponse,
        ),
      );
    } on DioException catch (e) {
      return Left(e.message ?? "Network error");
    } catch (e) {
      return Left("An unexpected error occurred");
    }
  }
}
