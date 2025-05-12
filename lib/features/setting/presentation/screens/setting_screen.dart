import 'package:e_cashier/core/constant/colors.dart';
import 'package:e_cashier/core/constant/colors.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/app_texts.dart';
import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import '../../../../core/data/local/storage_helper.dart';
import '../../../../core/widgets/app_background_scaffold.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../../core/widgets/floating_action_button.dart';
import '../../../branch_selection/presentation/screens/branch_selection_screen.dart';
import '../../../services_settings/presentation/screens/services_settings _screen.dart';
import '../widgets/sign_out_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool permission = false;

  getPermissions() async {
    permission = await StorageHelper.getPermissions();
    setState(() {});
    // print(permission);
  }

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return permission
        ? AppBackgroundScaffold(
          // isDrawerWidget: true,
          floatingActionButton: buildFloatingActionButton(
            showLeadingButton: true,
            showTrailButton: false,
            leadingButtonText: AppStrings(context: context).back,
            context,
            text: AppStrings(context: context).singIn,
            leadingButtonOnPressed: () {
              context.push(BranchSelection());
            },
            onPressed: () {},
          ),
          child: settingsListView(context),
        )
        : CircularProgressIndicator();
  }

  Widget settingsListView(BuildContext context) {
    List<String> settingsTexts = [
      AppStrings(context: context).serviceControls,
      AppStrings(context: context).branchSelection,
      AppStrings(context: context).signOut,
    ];
    return ListView.builder(
      itemCount: permission ? settingsTexts.length : 2,
      itemBuilder:
          (context, index) => settingsWidgets(context, index, settingsTexts),
    );
  }

  Widget settingsWidgets(BuildContext context, int index, List<String> list) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            if (index == 0) {
              context.push(ServicesSettingsScreen());
            } else if (index == 1) {
              context.push(BranchSelection());
            } else if (index == 2) {
              showSignOutDialog(context);
            }
          },
          child: Row(
            children: [
              AppTexts(
                context: context,
                text: list[index],
              ).textWhiteColor_w500_32,
            ],
          ),
        ),
        Divider(
          color: AppColors.dividerColor,
          height: responsiveHeight(context, 0.4),
        ),
      ],
    );
  }
}
