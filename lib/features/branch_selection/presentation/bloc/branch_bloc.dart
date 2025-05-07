import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/branch_model.dart';
import '../../domain/usecases/branch_usecase.dart';

part 'branch_event.dart';

part 'branch_state.dart';

// BLoC
class BranchBloc extends Bloc<BranchEvent, BranchState> {
  final BranchUseCase _branchUseCase;

  BranchBloc(this._branchUseCase) : super(BranchInitial()) {
    on<BranchEvent>((event, emit) async {
      if (event is BranchEvent) {
        emit(BranchLoading());
        var result = await _branchUseCase.call();
        result.fold(
          (l) => emit(BranchError(l)),
          (r) => emit(BranchSuccess(responseData: r)),
        );
      }
    });
  }
}
