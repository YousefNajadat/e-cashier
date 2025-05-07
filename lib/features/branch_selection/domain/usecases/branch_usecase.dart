import 'package:dartz/dartz.dart';

import '../../data/models/branch_model.dart';
import '../repositories/branch_repository.dart';

// features/branch_selection/domain/usecases/branch_usecase.dart
class BranchUseCase {
  final IBranchRepository repository;

  BranchUseCase({required this.repository});

  Future<Either<String, List<BranchModel>>> call() async {
    return await repository.getBranch();
  }
}