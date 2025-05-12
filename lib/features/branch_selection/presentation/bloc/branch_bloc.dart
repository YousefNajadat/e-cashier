import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/data/local/storage_helper.dart';
import '../../data/models/branch_model.dart';
import '../../domain/usecases/branch_usecase.dart';
import '../../domain/usecases/register_kiosk_usecase.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  final BranchUseCase _branchUseCase;
  final RegisterKioskUseCase _registerKioskUseCase;

  BranchBloc(this._branchUseCase, this._registerKioskUseCase)
      : super(BranchInitial()) {
    on<LoadBranches>(_onLoadBranches);
    on<RegisterKiosk>(_onRegisterKiosk);
  }

  Future<void> _onLoadBranches(
      LoadBranches event,
      Emitter<BranchState> emit,
      ) async {
    emit(BranchLoading());
    final result = await _branchUseCase();
    final branchId = await StorageHelper.getBranchId();
    result.fold(
          (l) => emit(BranchError(l)),
          (r) => emit(BranchSuccess(responseData: r, branchId: branchId)),
    );
  }

  Future<void> _onRegisterKiosk(
      RegisterKiosk event,
      Emitter<BranchState> emit,
      ) async {
    emit(BranchLoading());
    final result = await _registerKioskUseCase(event.branchId);
    result.fold(
          (l) => emit(BranchError(l)),
          (r) {
        // After successful registration, reload branches
        add(LoadBranches());
      },
    );
  }
}