import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/branch_selection/presentation/bloc/branch_bloc.dart';
import '../../features/branch_selection/presentation/cubit/show_sign_in_button/show_sign_in_button_cubit.dart';
import '../../features/log_in/presentation/bloc/log_in_bloc.dart';
import '../../main.dart';
import '../cubit/package_info/package_info_cubit.dart';
import 'package:nested/nested.dart';

import '../cubit/translation/translation_cubit.dart';

class AppProviders{
  const AppProviders();
  List<SingleChildWidget> get providers {
    return [
      BlocProvider(create: (_) => getIt<TranslationCubit>()),
      BlocProvider(create: (_) => getIt<PackageInfoCubit>()),
      BlocProvider(create: (_) => getIt<ShowSignInButtonCubit>()),
      BlocProvider(create: (_) => getIt<BranchBloc>()),
      BlocProvider(create: (_) => getIt<LogInBloc>()),
    ];
  }

}