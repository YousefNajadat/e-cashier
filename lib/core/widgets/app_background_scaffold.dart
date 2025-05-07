import 'package:e_cashier/core/constant/icons_path.dart';
import 'package:e_cashier/core/constant/images_path.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:e_cashier/core/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_cashier/core/constant/gifs_path.dart';
import 'package:gap/gap.dart';

import '../../features/branch_selection/presentation/widgets/branch_search_dropdown.dart';
import '../utils/Styles.dart';
import '../utils/app_strings.dart';

class AppBackgroundScaffold extends StatelessWidget {
  final List<Widget> children;
  final double topPadding;
  final double appNameHeight;
  final double appNameWidth;
  final Widget? floatingActionButton;

  const AppBackgroundScaffold({
    super.key,
    required this.children,
    this.topPadding = 88,
    this.appNameHeight = 91,
    this.appNameWidth = 225,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:floatingActionButton,
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
                  Center(
                    child: svgWidget(
                      context,
                      ImagesPath.app_name,
                      appNameHeight,
                      appNameWidth,
                    ),
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
}
