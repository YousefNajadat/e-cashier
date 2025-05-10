import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/features/phone_number/presentation/widgets/custom_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../../../core/widgets/app_background_scaffold.dart';
import '../../../../core/utils/Styles.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/responsive_size_helper.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});
  static TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBackgroundScaffold(
      isDrawerWidget: true,
      isChangeLang: true,
      children: [
        AppTexts(
          context: context,
          text: AppStrings(context: context).please_enter_your_phone_number,
        ).textWhiteColor_w500_38,
        Gap(responsiveHeight(context, 48)),
        //============== phone number widget ===================================
        CustomPhoneNumber(controller: phoneNumberController),
      ],
    );
  }
}
