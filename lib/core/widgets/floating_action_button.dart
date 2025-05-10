import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constant/colors.dart';
import '../utils/app_texts.dart';
import '../utils/responsive_size_helper.dart';
import '../../features/branch_selection/presentation/cubit/show_sign_in_button/show_sign_in_button_cubit.dart';
import 'custom_primary_button.dart';

Widget buildFloatingActionButton(
  BuildContext context, {
  required String text,
  String? leadingButtonText,
  required void Function() onPressed,
  void Function()? leadingButtonOnPressed,
  bool isLoading = false,
  bool showLeadingButton = false,
  bool showTrailButton = true,
}) {
  return BlocBuilder<ShowSignInButtonCubit, bool>(
    buildWhen: (previous, current) => previous != current,
    builder: (context, showButton) {
      if (!showButton) return const SizedBox();
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 48)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showLeadingButton
                ? CustomButton(
                  isAddBorder: true,
                  buttonColor: AppColors.transparent,
                  onPressed:
                      leadingButtonOnPressed ??
                      () {
                        context.pop();
                      },
                  text: leadingButtonText ?? '',
                )
                : const SizedBox(),
            showTrailButton
                ? CustomButton(onPressed: onPressed, text: text)
                : const SizedBox(),
          ],
        ),
      );
    },
  );
}
