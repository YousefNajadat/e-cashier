import '../../../../core/network/api_response_model.dart';
import '../../domain/params/services_settings_parameters.dart';

abstract class IServicesSettingsRemoteDataSource {
  Future<ApiResponse> getServicesSettings(
    ServicesSettingsParameters parameters,
  );
}
