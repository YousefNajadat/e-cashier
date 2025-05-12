import 'package:bloc/bloc.dart';
import 'package:e_cashier/core/data/local/storage_helper.dart';
import 'package:meta/meta.dart';

part 'show_sign_in_button_state.dart';

class ShowSignInButtonCubit extends Cubit<ShowSignInButtonState> {
  ShowSignInButtonCubit() : super(ShowSignInButtonInitial(visible: false)){
    checkInitialState();
  }

  Future<void> checkInitialState() async {
    final branchId = await StorageHelper.getBranchId();
    emit(ShowSignInButtonInitial(visible: branchId?.isNotEmpty ?? false));
    setVisible(branchId?.isNotEmpty ?? false);
  }

  void setVisible(bool visible) {
    emit(ShowSignInButtonInitial(visible: visible));
  }
}
