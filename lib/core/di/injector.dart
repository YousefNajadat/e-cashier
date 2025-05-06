// lib/core/di/injector.dart
import 'package:get_it/get_it.dart';

import '../../features/branch_selection/presentation/cubit/translation/translation_cubit.dart';
import '../utils/api_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Core Services
  getIt.registerSingleton<ApiService>(ApiService());

  // Blocs & Cubits
  getIt.registerFactory<TranslationCubit>(() => TranslationCubit());

}
