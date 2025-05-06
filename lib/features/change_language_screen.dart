import 'package:e_cashier/core/constant/icons_path.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_background_scaffold.dart';
import 'branch_selection/presentation/cubit/translation/translation_cubit.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return // Example usage:
    AppBackgroundScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppStrings(context: context).pleaseChooseTheLanguage),
          Text(AppStrings(context: context).pleaseChooseTheLanguageArabic),
          svgWidget(context, IconsPath.languageIcon, 50, 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed:
                    () => context.read<TranslationCubit>().setToEnglish(),
                child: const Text('English'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => context.read<TranslationCubit>().setToArabic(),
                child: const Text('Arabic'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<TranslationCubit>().toggleLanguage(),
            child: const Text('Toggle Language'),
          ),
        ],
      ),
    );
  }
}
