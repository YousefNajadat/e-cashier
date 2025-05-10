import 'package:bloc/bloc.dart';
import 'package:e_cashier/features/log_in/domain/entities/log_in_entity.dart';
import 'package:meta/meta.dart';
import '../../domain/params/log_in_parameters.dart';
import '../../domain/usecases/log_in_use_case.dart';

part 'log_in_event.dart';

part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final LogInUseCase _logInUseCase;

  LogInBloc(this._logInUseCase) : super(LogInInitial()) {
    on<LogInEvent>((event, emit) async {
      if (event is PostLogInEvent) {
        emit(LogInLoading());
        var result = await _logInUseCase.call(event.parameters);
        result.fold(
          (l) => emit(LogInError(l)),
          (r) => emit(LogInSuccess(responseData: r)),
        );
      }
    });
  }
}
