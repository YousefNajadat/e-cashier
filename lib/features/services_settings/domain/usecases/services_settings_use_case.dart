import 'package:dartz/dartz.dart';
import '../entities/services_settings_entity.dart';
import '../params/services_settings_parameters.dart';
import '../repositories/i_services_settings_repository.dart';

class ServicesSettingsUseCase {
  final IServicesSettingsRepository repository;

  ServicesSettingsUseCase({required this.repository});

  Future<Either<String, ServicesSettingsEntity>> call(
    ServicesSettingsParameters parameters,
  ) async {
    return await repository.getServicesSettings(parameters);
  }
}
