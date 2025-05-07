// lib/core/di/injector.dart
import 'package:get_it/get_it.dart';

import '../../features/branch_selection/data/datasources/branch_remote_data_source_impl.dart';
import '../../features/branch_selection/data/repositories/branch_repository_impl.dart';
import '../../features/branch_selection/domain/usecases/branch_usecase.dart';
import '../../features/branch_selection/presentation/bloc/branch_bloc.dart';
import '../../features/branch_selection/presentation/cubit/translation/translation_cubit.dart';
import '../network/e_cashier_rest.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Core Services
  getIt.registerSingleton<ECashierRest>(ECashierRest());

  // Data Sources
  getIt.registerSingleton<BranchRemoteDataSource>(
    BranchRemoteDataSource(getIt<ECashierRest>()),
  );


  // Repositories
  getIt.registerSingleton<BranchRepository>(
    BranchRepository(getIt<BranchRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerSingleton<BranchUseCase>(
    BranchUseCase(repository: getIt<BranchRepository>()),
  );

  // Blocs & Cubits
  getIt.registerFactory<TranslationCubit>(() => TranslationCubit());
  getIt.registerFactory<BranchBloc>(() => BranchBloc(getIt<BranchUseCase>()));
}
