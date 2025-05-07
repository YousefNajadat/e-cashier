import 'package:e_cashier/core/constant/page_routes.dart';
import 'package:e_cashier/core/utils/Styles.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/widgets/app_background_scaffold.dart';
import '../../../change_lang/presentation/screens/change_language_screen.dart';
import '../cubit/show_sign_in_button/show_sign_in_button_cubit.dart';
import '../widgets/branch_search_dropdown.dart';

class BranchSelection extends StatelessWidget {
  const BranchSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowSignInButtonCubit, bool>(
      builder: (context, index) {
        final cubit = context.read<ShowSignInButtonCubit>();
        return AppBackgroundScaffold(
          floatingActionButton:
              cubit.state
                  ? MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        responsiveFont(context, 6),
                      ),
                    ),
                    height: responsiveHeight(context, 80),
                    minWidth: responsiveWidth(context, 180),
                    color: AppColors.buttonColor,
                    onPressed: () {
                      context.pushAndRemoveUntil(ChangeLanguageScreen());
                    },
                    child: Text(
                      AppStrings(context: context).singIn,
                      style: Styles(context: context).textWhiteColor_w500_38,
                    ),
                  )
                  : SizedBox(),
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
                cubit.toggle(true);
              },
            ),
          ],
        );
      },
    );
  }
}
