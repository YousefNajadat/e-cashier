import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/update_branch_service_status_entity.dart';
import '../../../domain/params/update_branch_service_status_parameters.dart';
import '../../../domain/usecases/update_branch_service_status_use_case.dart';

part 'update_branch_service_status_event.dart';

part 'update_branch_service_status_state.dart';

class UpdateBranchServiceStatusBloc
    extends
        Bloc<UpdateBranchServiceStatusEvent, UpdateBranchServiceStatusState> {
  final UpdateBranchServiceStatusUseCase _updateBranchServiceStatusUseCase;

  UpdateBranchServiceStatusBloc(this._updateBranchServiceStatusUseCase)
    : super(UpdateBranchServiceStatusInitial()) {
    on<UpdateBranchServiceStatusEvent>((event, emit) async {
      if (event is UpdateBranchServiceStatus) {
        emit(UpdateBranchServiceStatusLoading());
        var result = await _updateBranchServiceStatusUseCase.call(
          event.parameters,
        );
        result.fold((l) => emit(UpdateBranchServiceStatusError(l)), (r) {
          emit(UpdateBranchServiceStatusSuccess(responseData: r));
        });
      }
    });
  }
}
