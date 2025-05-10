import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../features/log_in/presentation/screens/log_in_screen.dart';
import '../constant/colors.dart';
import '../constant/icons_path.dart';
import '../constant/images_path.dart';
import '../cubit/package_info/package_info_cubit.dart';
import '../utils/Styles.dart';
import '../utils/app_strings.dart';
import '../utils/responsive_size_helper.dart';
import 'image_widget.dart';

Widget appBackgroundScaffoldDrawer(BuildContext context) {
  return Container(
    width: responsiveWidth(context, 655),
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowColor,
          blurRadius: 20, // Blur: 20
          spreadRadius: 3, // Spread: 3
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(
                  color: Colors.transparent,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(responsiveHeight(context, 65)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: AppColors.textWhiteColor,
                          size: responsiveFont(context, 25),
                        ),
                      ),
                    ],
                  ),
                  Gap(responsiveHeight(context, 50)),
                  Center(
                    child: svgWidget(context, ImagesPath.app_name, 91, 225),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  imageWidget(context, IconsPath.icon_settings, 80, 80),
                  Gap(responsiveWidth(context, 12)),
                  Text(
                    AppStrings(context: context).kioskSettings,
                    style: Styles(context: context).textWhiteColor_w400_34,
                  ),
                ],
              ),
              onTap: () {
                context.push(LogInScreen());
              },
            ),
          ],
        ),
        Column(
          children: [
            ListTile(
              title: Column(
                children: [
                  Text(
                    AppStrings(context: context).check_for_updates,
                    style: Styles(context: context).textWhiteColor_w500_28,
                  ),
                  Gap(responsiveHeight(context, 16)),
                  BlocProvider(
                    create: (context) => PackageInfoCubit()..getPackageInfo(),
                    child: BlocBuilder<PackageInfoCubit, PackageInfoState>(
                      builder: (context, state) {
                        return Text(
                          '${AppStrings(context: context).version} '
                              '${state is PackageInfoLoaded ? state.packageInfo?.version : ''}',
                          style:
                          Styles(context: context).textGrayColor_w400_28,
                        );
                      },
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Gap(responsiveHeight(context, 64)),
          ],
        ),
      ],
    ),
  );
}
