import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:e_cashier/features/setting/presentation/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../../../core/widgets/app_background_scaffold.dart';
import '../../../../core/constant/app_constant.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/cubit/translation/translation_cubit.dart';
import '../../../../core/data/local/storage_helper.dart';
import '../../../../core/utils/Styles.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../phone_number/presentation/screens/phone_number_screen.dart';
class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
  }

  Future<void> _checkUserLoginStatus() async {
    final token = await StorageHelper.getAccessToken();
    setState(() {
      isUserLoggedIn = token != null && token.isNotEmpty;
    });
  }
  @override
  Widget build(BuildContext context) {
    return // Example usage:
    AppBackgroundScaffold(
      isDrawerWidget: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              CustomButton(
                verticalPadding: 26,
                onPressed: () {
                  context.read<TranslationCubit>().setToEnglish();
                  if(!isUserLoggedIn) {
                    context.push(PhoneNumberScreen());
                  }else{
                    context.push(SettingScreen());
                  }
                },
                text: Languages.english,
              ),
              Gap(responsiveWidth(context, 32)),
              CustomButton(
                verticalPadding: 26,
                onPressed: () {
                  context.read<TranslationCubit>().setToArabic();
                  if(!isUserLoggedIn) {
                    context.push(PhoneNumberScreen());
                  }else{
                    context.push(SettingScreen());
                  }
                },
                text: Languages.arabic,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
