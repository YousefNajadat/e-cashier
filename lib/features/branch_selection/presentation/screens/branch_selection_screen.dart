import 'package:e_cashier/core/constant/icons_path.dart';
import 'package:e_cashier/core/utils/Styles.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:e_cashier/core/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/app_background_scaffold.dart';
import '../cubit/translation/translation_cubit.dart';

class BranchSelection extends StatelessWidget {
  const BranchSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return // Example usage:
    AppBackgroundScaffold(
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
          ],
        ),
      ),
    );
  }
}
