import 'package:dartz/dartz.dart';

import '../../data/models/branch_model.dart';



// features/branch_selection/domain/repositories/branch_repository.dart
abstract class IBranchRepository {
  Future<Either<String, List<BranchModel>>> getBranch();

}