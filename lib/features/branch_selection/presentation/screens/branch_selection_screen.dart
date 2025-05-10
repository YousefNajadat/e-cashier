import 'package:e_cashier/core/utils/Styles.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/app_background_scaffold.dart';
import '../../../change_lang/presentation/screens/change_language_screen.dart';
import '../bloc/branch_bloc.dart';
import '../widgets/branch_search_dropdown.dart';
import '../../../../core/widgets/floating_action_button.dart';

class BranchSelection extends StatelessWidget {
  const BranchSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BranchBloc(getIt())..add(LoadBranches()),
      child: AppBackgroundScaffold(
        floatingActionButton: buildFloatingActionButton(
          context,
          text: AppStrings(context: context).singIn,
          onPressed: () {
            context.pushAndRemoveUntil(ChangeLanguageScreen());
          },
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child:
                AppTexts(
                  context: context,
                  text: AppStrings(context: context).pleaseChooseTheBranch,
                ).textWhiteColor_w500_38,
          ),
          Gap(responsiveHeight(context, 64)),
          BranchSearchDropdown(onChanged: (branch) {}),
        ],
      ),
    );
  }
}
