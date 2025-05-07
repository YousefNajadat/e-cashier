import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nested/nested.dart';
import 'core/constant/page_routes.dart';
import 'core/di/injector.dart';
import 'features/branch_selection/presentation/bloc/branch_bloc.dart';
import 'features/branch_selection/presentation/cubit/show_sign_in_button/show_sign_in_button_cubit.dart';
import 'features/branch_selection/presentation/cubit/translation/translation_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/l10n.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Setup dependency injection
  await setupDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  List<SingleChildWidget> get providers {
    return [
      BlocProvider(create: (_) => getIt<TranslationCubit>()),
      BlocProvider(create: (_) => getIt<ShowSignInButtonCubit>()),
      BlocProvider(create: (_) => getIt<BranchBloc>()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: BlocBuilder<TranslationCubit, TranslationState>(
        builder: (context, state) {
          final translationCubit = context.read<TranslationCubit>();
          translationCubit.setLanguage();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'e_cashier',
            locale: state.currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) => locale,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.white,
                surface: Colors.white,
              ),
            ),
            initialRoute: PageRoutes().initialRoute,
            routes: PageRoutes().pageRoutes,
          );
        },
      ),
    );
  }
}
