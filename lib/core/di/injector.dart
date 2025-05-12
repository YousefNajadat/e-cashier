// lib/core/di/injector.dart
import 'package:get_it/get_it.dart';
import '../../features/branch_selection/data/datasources/branch_remote_data_source_impl.dart';
import '../../features/branch_selection/data/repositories/branch_repository_impl.dart';
import '../../features/branch_selection/domain/usecases/branch_usecase.dart';
import '../../features/branch_selection/domain/usecases/register_kiosk_usecase.dart';
import '../../features/branch_selection/presentation/bloc/branch_bloc.dart';
import '../../features/branch_selection/presentation/cubit/show_sign_in_button/show_sign_in_button_cubit.dart';
import '../../features/log_in/data/datasources/log_in_remote_data_source.dart';
import '../../features/log_in/data/repositories/log_in_repository_impl.dart';
import '../../features/log_in/domain/usecases/log_in_use_case.dart';
import '../../features/log_in/presentation/bloc/log_in_bloc.dart';
import '../../features/services_settings/data/datasources/services_settings_remote_data_source.dart';
import '../../features/services_settings/data/datasources/update_branch_service_status_remote_data_source.dart';
import '../../features/services_settings/data/repositories/services_settings_repository_impl.dart';
import '../../features/services_settings/data/repositories/update_branch_service_status_repository_impl.dart';
import '../../features/services_settings/domain/usecases/services_settings_use_case.dart';
import '../../features/services_settings/domain/usecases/update_branch_service_status_use_case.dart';
import '../../features/services_settings/presentation/bloc/services_settings_bloc/services_settings_bloc.dart';
import '../../features/services_settings/presentation/bloc/update_branch_service_status_bloc/update_branch_service_status_bloc.dart';
import '../cubit/package_info/package_info_cubit.dart';
import '../cubit/translation/translation_cubit.dart';
import '../network/e_cashier_rest.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Core Services
  getIt.registerSingleton<ECashierRest>(ECashierRest());

  // Data Sources
  getIt.registerSingleton<BranchRemoteDataSource>(
    BranchRemoteDataSource(getIt<ECashierRest>()),
  );
  getIt.registerSingleton<LogInRemoteDataSource>(
    LogInRemoteDataSource(getIt<ECashierRest>()),
  );
  getIt.registerSingleton<ServicesSettingsRemoteDataSource>(
    ServicesSettingsRemoteDataSource(getIt<ECashierRest>()),
  );
  getIt.registerSingleton<UpdateBranchServiceStatusRemoteDataSource>(
    UpdateBranchServiceStatusRemoteDataSource(getIt<ECashierRest>()),
  );
  //==============================================================================
  // Repositories
  getIt.registerSingleton<BranchRepository>(
    BranchRepository(getIt<BranchRemoteDataSource>()),
  );
  getIt.registerSingleton<LogInRepository>(
    LogInRepository(getIt<LogInRemoteDataSource>()),
  );
  getIt.registerSingleton<ServicesSettingsRepositoryImpl>(
    ServicesSettingsRepositoryImpl(getIt<ServicesSettingsRemoteDataSource>()),
  );
  getIt.registerSingleton<UpdateBranchServiceStatusRepositoryImpl>(
    UpdateBranchServiceStatusRepositoryImpl(
      getIt<UpdateBranchServiceStatusRemoteDataSource>(),
    ),
  );

  //==============================================================================
  // Use Cases
  getIt.registerSingleton<BranchUseCase>(
    BranchUseCase(repository: getIt<BranchRepository>()),
  );
  getIt.registerSingleton<RegisterKioskUseCase>(
    RegisterKioskUseCase(repository: getIt<BranchRepository>()),
  );
  getIt.registerSingleton<LogInUseCase>(
    LogInUseCase(repository: getIt<LogInRepository>()),
  );
  getIt.registerSingleton<ServicesSettingsUseCase>(
    ServicesSettingsUseCase(
      repository: getIt<ServicesSettingsRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton<UpdateBranchServiceStatusUseCase>(
    UpdateBranchServiceStatusUseCase(
      repository: getIt<UpdateBranchServiceStatusRepositoryImpl>(),
    ),
  );

  //==============================================================================
  // Blocs & Cubits
  getIt.registerFactory<TranslationCubit>(() => TranslationCubit());
  getIt.registerFactory<PackageInfoCubit>(() => PackageInfoCubit());
  getIt.registerFactory<BranchBloc>(
    () => BranchBloc(getIt<BranchUseCase>(), getIt<RegisterKioskUseCase>()),
  );
  getIt.registerFactory<LogInBloc>(() => LogInBloc(getIt<LogInUseCase>()));

  getIt.registerFactory<ServicesSettingsBloc>(
    () => ServicesSettingsBloc(getIt<ServicesSettingsUseCase>()),
  );
  getIt.registerFactory<UpdateBranchServiceStatusBloc>(
    () => UpdateBranchServiceStatusBloc(
      getIt<UpdateBranchServiceStatusUseCase>(),
    ),
  );

  getIt.registerFactory<ShowSignInButtonCubit>(() => ShowSignInButtonCubit());
}
