import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_sign_in_button_state.dart';

class ShowSignInButtonCubit extends Cubit<bool> {
  ShowSignInButtonCubit() : super(false); // Initial value is false (unchecked)

  void toggle(bool a) => emit(a); // Toggle the state
}
