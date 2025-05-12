import 'package:e_cashier/core/data/local/storage_helper.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/app_background_scaffold.dart';
import '../../../../core/widgets/floating_action_button.dart';
import '../../../change_lang/presentation/screens/change_language_screen.dart';
import '../../../setting/presentation/screens/setting_screen.dart';
import '../bloc/branch_bloc.dart';
import '../cubit/show_sign_in_button/show_sign_in_button_cubit.dart';
import '../widgets/branch_search_dropdown.dart';

class BranchSelection extends StatefulWidget {
  const BranchSelection({super.key});

  @override
  State<BranchSelection> createState() => _BranchSelectionState();
}

class _BranchSelectionState extends State<BranchSelection> {
  bool isUserLoggedIn = false;
  bool isRegisteringKiosk = false;

  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
    _loadBranches();
  }

  Future<void> _checkUserLoginStatus() async {
    final token = await StorageHelper.getAccessToken();
    setState(() {
      isUserLoggedIn = token != null && token.isNotEmpty;
    });
  }

  void _loadBranches() {
    context.read<BranchBloc>().add(LoadBranches());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BranchBloc, BranchState>(
      listener: (context, state) {
        if (state is BranchError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          setState(() => isRegisteringKiosk = false);
        } else if (state is BranchSuccess) {
          setState(() => isRegisteringKiosk = false);
        }
      },
      child: AppBackgroundScaffold(
        onPressed: () {
          context.read<BranchBloc>().add(LoadBranches());
        },
        isChangeLang: true,
        padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 88)),
        floatingActionButton:
            BlocBuilder<ShowSignInButtonCubit, ShowSignInButtonState>(
              builder: (context, state) {
                if (state is ShowSignInButtonLoading) {
                  return const SizedBox();
                } else if (state is ShowSignInButtonInitial && state.visible) {
                  return buildFloatingActionButton(
                    context,
                    text:
                        isUserLoggedIn
                            ? AppStrings(context: context).confirm
                            : AppStrings(context: context).singIn,
                    onPressed: () {
                      isUserLoggedIn
                          ? context.push(const ChangeLanguageScreen())
                          : context.push(const ChangeLanguageScreen());
                    },
                    showTrailButton: true,
                    isLoading: isRegisteringKiosk,
                  );
                }
                return const SizedBox();
              },
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            BranchSearchDropdown(
              onChanged: (branch) async {
                if (branch != null) {
                  setState(() => isRegisteringKiosk = true);
                  await StorageHelper.setBranchId(branch.id.toString());
                  context.read<BranchBloc>().add(RegisterKiosk(branch.id!));
                  context.read<ShowSignInButtonCubit>().setVisible(true);
                } else {
                  context.read<ShowSignInButtonCubit>().setVisible(false);
                }
              },
            ),
            // if (isRegisteringKiosk)
            //   const Padding(
            //     padding: EdgeInsets.only(top: 16.0),
            //     child: CircularProgressIndicator(),
            //   ),
          ],
        ),
      ),
    );
  }
}
