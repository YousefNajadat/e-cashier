part of 'services_settings_bloc.dart';

@immutable
sealed class ServicesSettingsEvent {
  const ServicesSettingsEvent();
}

class GetServicesSettingsEvent extends ServicesSettingsEvent {
  final ServicesSettingsParameters? parameters;

  const GetServicesSettingsEvent({this.parameters});
}

class UpdateServiceStatusEvent extends ServicesSettingsEvent {
  final String serviceId;
  final bool isEnabled;

  const UpdateServiceStatusEvent({
    required this.serviceId,
    required this.isEnabled,
  });

  @override
  List<Object> get props => [serviceId, isEnabled];
}
