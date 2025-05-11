import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../constant/font_family.dart';

class Styles {
  final BuildContext context;

  Styles({required this.context});

  TextStyle get textWhiteColor_w500_42 {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.textWhiteColor,
      fontSize: responsiveFont(context, 12.5),
      fontFamily: FontFamily.encodeSans,
    );
  }

  TextStyle get textWhiteColor_w500_38 {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.textWhiteColor,
      fontSize: responsiveFont(context, 11),
      fontFamily: FontFamily.encodeSans,
    );
  }

  TextStyle get textWhiteColor_w500_28 {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.textWhiteColor,
      fontSize: responsiveFont(context, 8.5),
      fontFamily: FontFamily.encodeSans,
    );
  }

  TextStyle get textWhiteColor_w400_30 {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.textWhiteColor,
      fontSize: responsiveFont(context, 9),
      fontFamily: FontFamily.encodeSans,
    );
  }

  TextStyle get textWhiteColor_w400_32 {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.textWhiteColor,
      fontSize: responsiveFont(context, 9.5),
      fontFamily: FontFamily.encodeSans,
    );
  }

  TextStyle get textWhiteColor_w500_32 {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.textWhiteColor,
      fontSize: responsiveFont(context, 9.5),
      fontFamily: FontFamily.encodeSans,
    );
  }

  TextStyle get textWhiteColor_w400_34 {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.textWhiteColor,
      fontSize: responsiveFont(context, 10),
      fontFamily: FontFamily.encodeSans,
    );
  }

  TextStyle get hintTextColor_w400_30 {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.hintTextColor,
      fontSize: responsiveFont(context, 9),
      fontFamily: FontFamily.encodeSans,
    );
  }

  TextStyle get hintTextColor_w400_32 {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.hintTextColor,
      fontSize: responsiveFont(context, 9.5),
      fontFamily: FontFamily.encodeSans,
    );
  }

  TextStyle get whiteColor_w400_24 {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.whiteColor,
      fontSize: responsiveFont(context, 7),
      fontFamily: FontFamily.encodeSans,
    );
  }

  TextStyle get textGrayColor_w400_28 {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.textGrayColor,
      fontSize: responsiveFont(context, 8.5),
      fontFamily: FontFamily.encodeSans,
    );
  }
}
