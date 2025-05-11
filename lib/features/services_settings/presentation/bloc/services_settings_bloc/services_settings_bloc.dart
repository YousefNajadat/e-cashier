import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/services_settings_entity.dart';
import '../../../domain/params/services_settings_parameters.dart';
import '../../../domain/usecases/services_settings_use_case.dart';

part 'services_settings_event.dart';
part 'services_settings_state.dart';

class ServicesSettingsBloc extends Bloc<ServicesSettingsEvent, ServicesSettingsState> {
  final ServicesSettingsUseCase _servicesSettingsUseCase;
  ServicesSettingsEntity? _currentSettings;

  ServicesSettingsBloc(this._servicesSettingsUseCase) : super(ServicesSettingsInitial()) {
    on<GetServicesSettingsEvent>(_onGetServicesSettings);
    on<UpdateServiceStatusEvent>(_onUpdateServiceStatus);
  }

  Future<void> _onGetServicesSettings(
      GetServicesSettingsEvent event,
      Emitter<ServicesSettingsState> emit,
      ) async {
    emit(ServicesSettingsLoading());
    final result = await _servicesSettingsUseCase.call(event.parameters);

    result.fold(
          (error) => emit(ServicesSettingsError(error)),
          (settings) {
        _currentSettings = settings;
        emit(ServicesSettingsSuccess(responseData: settings));
      },
    );
  }

  Future<void> _onUpdateServiceStatus(
      UpdateServiceStatusEvent event,
      Emitter<ServicesSettingsState> emit,
      ) async {
    if (_currentSettings == null || _currentSettings!.services == null) return;

    final updatedServices = _currentSettings!.services!.map((service) {
      if (service.serviceId.toString() == event.serviceId) {
        return service.copyWith(
          isEnabled: event.isEnabled,
          isModified: true,
        );
      }
      return service;
    }).toList();

    _currentSettings = _currentSettings!.copyWith(services: updatedServices);
    emit(ServicesSettingsSuccess(responseData: _currentSettings!));
  }
}