// features/log_in/data/repositories/log_in_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/log_in_entity.dart';
import '../../domain/params/log_in_parameters.dart';
import '../../domain/repositories/i_log_in_repository.dart';
import '../datasources/i_log_in_remote_data_source.dart';
import '../datasources/log_in_remote_data_source.dart';
import '../models/log_in_response.dart';

class LogInRepository implements ILogInRepository {
  final ILogInRemoteDataSource remoteDataSource;

  LogInRepository(this.remoteDataSource);

  @override
  Future<Either<String, LogInEntity>> login(LogInParameters parameters) async {
    try {
      final response = await remoteDataSource.login(parameters);

      if (!response.success) {
        return Left(response.message ?? "Login failed");
      }

      final loginResponse = LoginResponse(
        accessToken: response.accessToken!,
        permissions: response.permissions!,
      );
      return Right(LogInEntity.fromResponse(loginResponse));
    } on DioException catch (e) {
      return Left(e.message ?? "Network error");
    } catch (e) {
      return Left("An unexpected error occurred");
    }
  }
}
