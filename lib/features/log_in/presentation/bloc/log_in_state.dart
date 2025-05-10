part of 'log_in_bloc.dart';

@immutable
sealed class LogInState {}

class LogInInitial extends LogInState {
  @override
  List<Object> get props => [];
}

class LogInLoading extends LogInState {
  @override
  List<Object> get props => [];
}

final class LogInSuccess extends LogInState {
  final LogInEntity responseData;

  LogInSuccess({required this.responseData});

  @override
  List<Object> get props => [responseData];
}

final class LogInError extends LogInState {
  final String message;

  LogInError(this.message);

  @override
  List<Object> get props => [message];
}
