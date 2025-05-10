part of 'services_settings_bloc.dart';

@immutable
sealed class ServicesSettingsState {}

final class ServicesSettingsInitial extends ServicesSettingsState {
  @override
  List<Object> get props => [];
}

class ServicesSettingsLoading extends ServicesSettingsState {
  @override
  List<Object> get props => [];
}

final class ServicesSettingsSuccess extends ServicesSettingsState {
  final ServicesSettingsEntity responseData;

  ServicesSettingsSuccess({required this.responseData});

  @override
  List<Object> get props => [responseData];
}

final class ServicesSettingsError extends ServicesSettingsState {
  final String message;

  ServicesSettingsError(this.message);

  @override
  List<Object> get props => [message];
}

