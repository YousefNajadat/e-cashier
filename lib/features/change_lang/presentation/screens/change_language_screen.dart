import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../../../core/widgets/app_background_scaffold.dart';
import '../../../../core/constant/app_constant.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/utils/Styles.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../branch_selection/presentation/cubit/translation/translation_cubit.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return // Example usage:
    AppBackgroundScaffold(
      children: [
        Text(
          AppStrings(context: context).pleaseChooseTheLanguage,
          style: Styles(context: context).textWhiteColor_w500_42,
        ),
        Text(
          AppStrings(context: context).pleaseChooseTheLanguageArabic,
          style: Styles(context: context).textWhiteColor_w500_42,
        ),
        Gap(responsiveHeight(context, 72)),
        // svgWidget(context, IconsPath.languageIcon, 50, 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 32),
                vertical: responsiveHeight(context, 26),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(responsiveFont(context, 6)),
              ),
              height: responsiveHeight(context, 100),
              minWidth: responsiveWidth(context, 190),
              color: AppColors.buttonColor,
              onPressed: () => context.read<TranslationCubit>().setToEnglish(),
              child: Text(
                Languages.english,
                style: Styles(context: context).textWhiteColor_w500_38,
              ),
            ),
            Gap(responsiveWidth(context, 32)),
            MaterialButton(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 32),
                vertical: responsiveHeight(context, 26),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(responsiveFont(context, 6)),
              ),
              height: responsiveHeight(context, 100),
              minWidth: responsiveWidth(context, 190),
              color: AppColors.buttonColor,
              onPressed: () => context.read<TranslationCubit>().setToArabic(),
              child: Text(
                Languages.arabic,
                style: Styles(context: context).textWhiteColor_w500_38,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
