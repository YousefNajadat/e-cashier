// features/log_in/domain/repositories/log_in_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/log_in_entity.dart';
import '../params/log_in_parameters.dart';

// features/login/domain/repositories/login_repository.dart
abstract class ILogInRepository {
  Future<Either<String, LogInEntity>> login(LogInParameters parameters);
}