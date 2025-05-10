import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../../../core/widgets/app_background_scaffold.dart';
import '../../../../core/constant/app_constant.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/cubit/translation/translation_cubit.dart';
import '../../../../core/utils/Styles.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../phone_number/presentation/screens/phone_number_screen.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return // Example usage:
    AppBackgroundScaffold(
      isDrawerWidget: true,
      children: [
        AppTexts(
          context: context,
          text: AppStrings(context: context).pleaseChooseTheLanguage,
        ).textWhiteColor_w500_42,
        AppTexts(
          context: context,
          text: AppStrings(context: context).pleaseChooseTheLanguageArabic,
        ).textWhiteColor_w500_42,
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
              onPressed: () {
                context.read<TranslationCubit>().setToEnglish();
                context.push(PhoneNumberScreen());
              },
              child:
                  AppTexts(
                    context: context,
                    text: Languages.english,
                  ).textWhiteColor_w500_38,
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
              onPressed: () {
                context.read<TranslationCubit>().setToArabic();
                context.push(PhoneNumberScreen());
              },
              child:
                  AppTexts(
                    context: context,
                    text: Languages.arabic,
                  ).textWhiteColor_w500_38,
            ),
          ],
        ),
      ],
    );
  }
}
