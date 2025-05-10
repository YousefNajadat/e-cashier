import 'package:e_cashier/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'core/constant/page_routes.dart';
import 'core/cubit/translation/translation_cubit.dart';
import 'core/di/injector.dart';
import 'core/utils/app_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/widgets/app_background_scaffold.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProviders().providers,
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
              appBarTheme: AppBarTheme(
                elevation: 0, // This removes the shadow from all App Bars.
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
                surface: AppColors.primaryColor,
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
