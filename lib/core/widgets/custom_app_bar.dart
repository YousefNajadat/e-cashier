import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/translation/translation_cubit.dart';
import '../utils/responsive_size_helper.dart';
import 'image_widget.dart';
import 'package:e_cashier/core/constant/icons_path.dart';
import 'package:e_cashier/core/constant/images_path.dart';
import 'package:gap/gap.dart';
import '../utils/Styles.dart';
import '../utils/app_strings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool isChangeLang;
  final void Function()? onPressed;

  const CustomAppBar({
    super.key,
    required this.height,
    required this.isChangeLang,
    this.onPressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      shape: const LinearBorder(),
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading:
          isChangeLang
              ? IconButton(
                onPressed: () {
                  context.read<TranslationCubit>().toggleLanguage();
                  if(onPressed != null) onPressed!();
                },
                icon: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    svgWidget(context, IconsPath.languageIcon, 50, 50),
                    Gap(responsiveWidth(context, 26)),
                    Text(
                      AppStrings(context: context).lang,
                      style: Styles(context: context).whiteColor_w400_24,
                    ),
                  ],
                ),
              )
              : null,
      leadingWidth: isChangeLang ? responsiveWidth(context, 300) : 0,
      centerTitle: true,
      title: svgWidget(context, ImagesPath.app_name, 91, 225),
    );
  }
}
