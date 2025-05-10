import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/services_settings_entity.dart';
import '../../domain/params/services_settings_parameters.dart';
import '../../domain/repositories/i_services_settings_repository.dart';
import '../datasources/i_services_settings_remote_data_source.dart';
import '../models/services_settings_response.dart';

class ServicesSettingsRepositoryImpl implements IServicesSettingsRepository {
  final IServicesSettingsRemoteDataSource remoteDataSource;

  ServicesSettingsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, ServicesSettingsEntity>> getServicesSettings(
    ServicesSettingsParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.getServicesSettings(parameters);

      if (!response.success) {
        return Left(response.message ?? "ServicesSettings failed");
      }

      final servicesSettingsResponse = ServicesSettingsResponse.fromJson(
        response.data,
      );
      return Right(
        ServicesSettingsEntity.fromResponse(servicesSettingsResponse),
      );
    } on DioException catch (e) {
      return Left(e.message ?? "Network error");
    } catch (e) {
      return Left("An unexpected error occurred");
    }
  }
}
