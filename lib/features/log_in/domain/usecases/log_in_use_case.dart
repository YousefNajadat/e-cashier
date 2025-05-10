import 'package:dartz/dartz.dart';

import '../entities/log_in_entity.dart';
import '../params/log_in_parameters.dart';
import '../repositories/i_log_in_repository.dart';

// features/login/domain/usecases/login_usecase.dart
class LogInUseCase {
  final ILogInRepository repository;

  LogInUseCase({required this.repository});

  Future<Either<String, LogInEntity>> call(LogInParameters parameters) async {
    return await repository.login(parameters);
  }
}