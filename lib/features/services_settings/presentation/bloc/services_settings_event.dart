part of 'services_settings_bloc.dart';

@immutable
sealed class ServicesSettingsEvent {
  const ServicesSettingsEvent();

  @override
  List<Object> get props => [];
}

class GetServicesSettingsEvent extends ServicesSettingsEvent {
  final ServicesSettingsParameters parameters;

  const GetServicesSettingsEvent({required this.parameters});
}
// Add this to your events
class UpdateServiceStatusEvent extends ServicesSettingsEvent {
  final String branchId;
  final String serviceId;
  final bool isEnabled;

  const UpdateServiceStatusEvent({
    required this.branchId,
    required this.serviceId,
    required this.isEnabled,
  });
}