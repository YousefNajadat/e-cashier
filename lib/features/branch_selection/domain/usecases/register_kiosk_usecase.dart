import 'package:dartz/dartz.dart';

import '../repositories/branch_repository.dart';

class RegisterKioskUseCase {
  final IBranchRepository repository;

  RegisterKioskUseCase({required this.repository});

  Future<Either<String, void>> call(int branchId) async {
    return await repository.registerKiosk(branchId);
  }
}