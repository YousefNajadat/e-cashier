// show_sign_in_button_cubit.dart
part of 'show_sign_in_button_cubit.dart';

@immutable
abstract class ShowSignInButtonState {}

class ShowSignInButtonInitial extends ShowSignInButtonState {
  final bool visible;
  ShowSignInButtonInitial({required this.visible});
}

class ShowSignInButtonLoading extends ShowSignInButtonState {}

