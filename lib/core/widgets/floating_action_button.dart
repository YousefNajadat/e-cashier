import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constant/colors.dart';
import '../utils/app_texts.dart';
import '../utils/responsive_size_helper.dart';
import '../../features/branch_selection/presentation/cubit/show_sign_in_button/show_sign_in_button_cubit.dart';

Widget buildFloatingActionButton(
  BuildContext context, {
  required String text,
  required void Function() onPressed,
  bool isLoading = false,
}) {
  return BlocBuilder<ShowSignInButtonCubit, bool>(
    buildWhen: (previous, current) => previous != current,
    builder: (context, showButton) {
      if (!showButton) return const SizedBox();
      return MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsiveFont(context, 6)),
        ),
        height: responsiveHeight(context, 80),
        minWidth: responsiveWidth(context, 180),
        color: AppColors.buttonColor,
        onPressed: onPressed,
        child:
            isLoading
                ? CircularProgressIndicator()
                : AppTexts(context: context, text: text).textWhiteColor_w500_38,
      );
    },
  );
}
