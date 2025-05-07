import 'package:e_cashier/core/utils/Styles.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/app_background_scaffold.dart';
import '../widgets/branch_search_dropdown.dart';

class BranchSelection extends StatelessWidget {

bool isShowSignInButton = false;
  @override
  Widget build(BuildContext context) {
    return AppBackgroundScaffold(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 88)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings(context: context).pleaseChooseTheBranch,
                style: Styles(context: context).textWhiteColor_w500_38,
              ),
            ),
            Gap(responsiveHeight(context, 64)),
            BranchSearchDropdown(
              onChanged: (branch) {
                print(branch!.branchNameAr!);
                isShowSignInButton = true;
              },
            ),
            if(isShowSignInButton)TextButton(onPressed: () {}, child: Text('SingIn')),
          ],
        ),
      ),
    );
  }
}
