import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/services_settings_entity.dart';
import '../../domain/params/services_settings_parameters.dart';
import '../../domain/usecases/services_settings_use_case.dart';

part 'services_settings_event.dart';

part 'services_settings_state.dart';

class ServicesSettingsBloc
    extends Bloc<ServicesSettingsEvent, ServicesSettingsState> {
  final ServicesSettingsUseCase _servicesSettingsUseCase;

  ServicesSettingsBloc(this._servicesSettingsUseCase)
    : super(ServicesSettingsInitial()) {
    on<ServicesSettingsEvent>((event, emit) async {
      if (event is GetServicesSettingsEvent) {
        emit(ServicesSettingsLoading());
        var result = await _servicesSettingsUseCase.call(event.parameters);
        result.fold(
          (l) => emit(ServicesSettingsError(l)),
          (r) => emit(ServicesSettingsSuccess(responseData: r)),
        );
      }else if(state is UpdateServiceStatusEvent){

      }
    });
  }
}
