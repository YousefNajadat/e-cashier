import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_cashier/features/branch_selection/data/models/branch_model.dart';
import '../../domain/repositories/branch_repository.dart';
import '../datasources/branch_remote_data_source.dart';

// features/branch_selection/data/repositories/branch_repository_impl.dart
class BranchRepository implements IBranchRepository {
  final IBranchRemoteDataSource _remoteDataSource;

  BranchRepository(this._remoteDataSource);

  @override
  Future<Either<String, List<BranchModel>>> getBranch() async {
    try {
      final response = await _remoteDataSource.getBranch();
      if (response.success) {
        List<BranchModel> branches =
            (response.data as List)
                .map((e) => BranchModel.fromJson(e))
                .toList();
        return Right(branches);
      }
      return Left(response.message ?? "error_message");
    } on DioException catch (e) {
      return Left(e.message ?? 'error_message');
    } catch (_) {
      return const Left('An unexpected error occurred');
    }
  }
}
