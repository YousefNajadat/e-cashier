import 'package:e_cashier/core/utils/Styles.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/features/phone_number/presentation/widgets/phone_field_extends.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/utils/responsive_size_helper.dart';

class CustomPhoneNumber extends StatelessWidget {
  const CustomPhoneNumber({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      disableLengthCheck: true,
      controller: controller,
      focusNode: FocusNode(),

      dropdownIconPosition: IconPosition.trailing,
      dropdownIcon: Icon(
        Icons.keyboard_arrow_down_sharp,
        color: AppColors.whiteColor,
      ),
      dropdownTextStyle: Styles(context: context).textWhiteColor_w400_32,

      flagsButtonPadding: EdgeInsets.only(left: responsiveWidth(context, 24)),
      // Adjust padding as needed
      flagsButtonMargin: EdgeInsets.zero,

      // Remove any margin
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: AppStrings(context: context).phone_Number,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColors.buttonColor,
        filled: true,
        border: inputBorder(context),
        enabledBorder: inputBorder(context),
        focusedBorder: inputBorder(context),
      ),
      initialCountryCode: "JO",
      languageCode: "jo",
      onChanged: (phone) {},
      onCountryChanged: (country) {},
    );
  }

  InputBorder inputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(responsiveFont(context, 6)),
      borderSide: BorderSide(
        width: responsiveWidth(context, 0.8),
        color: AppColors.textWhiteColor,
      ),
    );
  }
}
