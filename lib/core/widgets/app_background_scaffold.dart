import 'package:e_cashier/core/constant/colors.dart';
import 'package:e_cashier/core/constant/icons_path.dart';
import 'package:e_cashier/core/constant/images_path.dart';
import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:e_cashier/core/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_cashier/core/constant/gifs_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../features/log_in/presentation/screens/log_in_screen.dart';
import '../cubit/package_info/package_info_cubit.dart';
import '../cubit/translation/translation_cubit.dart';
import '../utils/Styles.dart';
import '../utils/app_strings.dart';

class AppBackgroundScaffold extends StatelessWidget {
  final List<Widget> children;
  final double topPadding;
  final bool isChangeLang;
  final Widget? floatingActionButton;
  final bool isDrawerWidget;

  AppBackgroundScaffold({
    super.key,
    required this.children,
    this.topPadding = 88,
    this.floatingActionButton,
    this.isChangeLang = false,
    this.isDrawerWidget = false,
  });

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: isDrawerWidget ? drawer(context) : null,
      floatingActionButton: floatingActionButton,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Background GIF
              imageWidget(
                context,
                GifsPath.backgroundGif,
                1920,
                1080,
                fit: BoxFit.cover,
              ),

              // App name at the top with padding
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(responsiveHeight(context, topPadding)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child:
                            isChangeLang
                                ? IconButton(
                                  onPressed: () {
                                    context
                                        .read<TranslationCubit>()
                                        .toggleLanguage();
                                  },
                                  icon: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      svgWidget(
                                        context,
                                        IconsPath.languageIcon,
                                        50,
                                        50,
                                      ),
                                      Gap(responsiveWidth(context, 26)),
                                      Text(
                                        AppStrings(context: context).lang,
                                        style:
                                            Styles(
                                              context: context,
                                            ).whiteColor_w400_24,
                                      ),
                                    ],
                                  ),
                                )
                                : SizedBox(),
                      ),
                      Expanded(
                        flex: 1,
                        child: svgWidget(context, ImagesPath.app_name, 91, 225),
                      ),
                      Expanded(
                        flex: 1,
                        child:
                            isDrawerWidget
                                ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Scaffold.of(context).openDrawer();
                                        scaffoldKey.currentState!
                                            .openEndDrawer();
                                      },
                                      icon: svgWidget(
                                        context,
                                        IconsPath.settings_icon,
                                        34,
                                        50,
                                      ),
                                    ),
                                  ],
                                )
                                : SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),

              //  area for the child content (centered)
              Center(
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(context, 88),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawer(BuildContext context) {
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
}
