import 'package:e_cashier/core/utils/Styles.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/app_texts.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constant/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final bool isPassword;
  final bool isRequired;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    this.isRequired = false,
    this.controller,
    this.onChanged,
    this.validator,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          AppTexts(
            context: context,
            text: labelText ?? '',
          ).textWhiteColor_w500_38,
          Gap(responsiveHeight(context, 32)),
        ],
        Container(
          constraints: BoxConstraints(
            minHeight: responsiveHeight(context, 104),
            maxHeight: responsiveHeight(context, 160),
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            obscureText: isPassword,
            validator: validator ?? (value) => _validateField(context, value),
            style: Styles(context: context).textWhiteColor_w400_32,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Styles(context: context).hintTextColor_w400_32,
              border: _inputBorder(context),
              enabledBorder: _inputBorder(context),
              focusedBorder: _inputBorder(context),
              contentPadding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 32),
              ),
            ),
          ),
        ),
      ],
    );
  }

  InputBorder _inputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(responsiveFont(context, 8)),
      borderSide: BorderSide(
        color: AppColors.textWhiteColor,
        width: responsiveWidth(context, 1),
      ),
    );
  }

  bool _containsNumber(String value) {
    return value.contains(RegExp(r'[0-9]'));
  }

  String? _validateField(BuildContext context, String? value) {
    if (isRequired && (value == null || value.isEmpty)) {
      return AppStrings(context: context).requiredField;
    }
    if (isPassword) {
      if (value != null && value.length < 6) {
        return AppStrings(context: context).passwordLength;
      }
      if (!_containsNumber(value!)) {
        return AppStrings(context: context).passwordNumberValidation;
      }
    }
    return null;
  }
}
