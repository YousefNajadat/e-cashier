import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/data/local/storage_helper.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../branch_selection/presentation/screens/branch_selection_screen.dart';

void showSignOutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: AppColors.primaryColor.withOpacity(0.9),
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsiveFont(context, 6)),
          side: BorderSide(
            color: AppColors.textWhiteColor,
            width: responsiveWidth(context, 1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(responsiveWidth(context, 24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTexts(
                context: context,
                text: AppStrings(context: context).signOut,
              ).textWhiteColor_w500_32,
              SizedBox(height: responsiveHeight(context, 24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    text: AppStrings(context: context).back,
                    onPressed: () => Navigator.of(context).pop(),
                    isAddBorder: true,
                    buttonColor: Colors.transparent,
                    verticalPadding: 8,
                  ),
                  CustomButton(
                    text: AppStrings(context: context).confirm,
                    onPressed: () {
                      Navigator.of(context).pop();
                      StorageHelper.signOut();
                      context.pushAndRemoveUntil(const BranchSelection());
                    },
                    verticalPadding: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}