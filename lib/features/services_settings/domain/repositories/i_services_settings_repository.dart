import 'package:dartz/dartz.dart';

import '../entities/services_settings_entity.dart';
import '../params/services_settings_parameters.dart';

abstract class IServicesSettingsRepository {
  Future<Either<String, ServicesSettingsEntity>> getServicesSettings(
    ServicesSettingsParameters parameters,
  );
}
