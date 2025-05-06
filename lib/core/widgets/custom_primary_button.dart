import 'package:flutter/material.dart';

import '../constant/app_constant.dart';
import '../constant/colors.dart';
import '../utils/Styles.dart';
import '../utils/responsive_size_helper.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color textColor;
  final Color buttonColor;
  final double fontSize;
  final double? height;
  final double? width;
  final double radius;
  final bool isOutlined;
  final bool isTextUnderlined;
  final IconData? iconData;
  final TextStyle? textStyle;
  final bool? small;
  final bool? isLoading; // إضافة حالة التحميل

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor = Colors.white,
    this.buttonColor = AppColors.primaryColor,
    this.fontSize = FontSize.size24,
    this.height,
    this.width,
    this.radius = 17,
    this.isOutlined = false,
    this.iconData,
    this.isTextUnderlined = false,
    this.textStyle,
    this.small = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = height != null
        ? responsiveHeight(context, height!)
        : responsiveHeight(context, 50);
    final double buttonWidth = width != null
        ? responsiveWidth(context, width!)
        : responsiveWidth(context, 355);

    return Material(
      color: isOutlined ? Colors.transparent : buttonColor,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: isLoading! ? null : onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: small! ? null : buttonWidth,
          height: small! ? null : buttonHeight,
          padding: small!
              ? EdgeInsets.symmetric(
                  vertical: responsiveHeight(context, 15),
                  horizontal: responsiveWidth(context, 25))
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: isOutlined
                ? Border.all(
                    color: buttonColor,
                    width: 2,
                  )
                : null,
            boxShadow: isOutlined
                ? null
                : [
                    BoxShadow(
                      color: buttonColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                    )
                  ], 
          ),
          alignment: Alignment.center,
          child: isLoading!
              ? CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (iconData != null) ...[
                      Icon(
                        iconData,
                        size: 17,
                        color: isOutlined ? buttonColor : textColor,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                    ],
                    Text(
                      text,
                      style: textStyle
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
