import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../utils/app_texts.dart';
import '../utils/responsive_size_helper.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isLoading;
  final bool isAddBorder;
  final Color buttonColor;
  final double verticalPadding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isAddBorder = false,
    this.buttonColor = AppColors.buttonColor,
    this.verticalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(context, 32),
        vertical: responsiveHeight(context, verticalPadding),
      ),
      shape: RoundedRectangleBorder(
        side:
            isAddBorder
                ? BorderSide(
                  color: AppColors.textWhiteColor,
                  width: responsiveWidth(context, 1),
                )
                : BorderSide.none,
        borderRadius: BorderRadius.circular(responsiveFont(context, 6)),
      ),
      color: buttonColor,
      onPressed: onPressed,
      child:
          isLoading
              ? CircularProgressIndicator()
              : AppTexts(context: context, text: text).textWhiteColor_w500_38,
    );
  }
}
