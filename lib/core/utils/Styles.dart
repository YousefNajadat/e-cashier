import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import '../constant/app_constant.dart';
import '../constant/colors.dart';

class Styles {
  final BuildContext context;
  final Color? color;

  Styles({
    required this.context,
    this.color,
  });


  TextStyle get textWhiteColor_w500_38 {
    return TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.textWhiteColor,
        fontSize: responsiveFont(context, 12),
        // fontFamily: FontFamily.Tajawal_Bold
    );
  }

}
