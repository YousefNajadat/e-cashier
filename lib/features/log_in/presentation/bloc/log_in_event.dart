part of 'log_in_bloc.dart';

@immutable
sealed class LogInEvent {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class PostLogInEvent extends LogInEvent {
  final LogInParameters parameters;

  const PostLogInEvent(this.parameters);
}
