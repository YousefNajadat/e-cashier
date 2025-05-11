part of 'services_settings_bloc.dart';

@immutable
sealed class ServicesSettingsState {}

class ServicesSettingsInitial extends ServicesSettingsState {}

class ServicesSettingsLoading extends ServicesSettingsState {}

class ServicesSettingsSuccess extends ServicesSettingsState {
  final ServicesSettingsEntity responseData;

  ServicesSettingsSuccess({required this.responseData});

  @override
  List<Object> get props => [responseData];
}

class ServicesSettingsError extends ServicesSettingsState {
  final String message;

  ServicesSettingsError(this.message);

  @override
  List<Object> get props => [message];
}