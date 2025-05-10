import 'package:e_cashier/core/constant/icons_path.dart';
import 'package:e_cashier/core/constant/images_path.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:e_cashier/core/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_cashier/core/constant/gifs_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../cubit/translation/translation_cubit.dart';
import '../utils/Styles.dart';
import '../utils/app_strings.dart';
import 'app_background_scaffold_drawer.dart';
import 'custom_app_bar.dart';

class AppBackgroundScaffold extends StatelessWidget {
  final Widget child;
  final bool isChangeLang;
  final Widget? floatingActionButton;
  final bool isDrawerWidget;
  final EdgeInsets padding;

  AppBackgroundScaffold({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.isChangeLang = false,
    this.isDrawerWidget = false,
    this.padding = EdgeInsets.zero,
  });

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background GIF
        imageWidget(
          context,
          GifsPath.backgroundGif,
          1920,
          1080,
          fit: BoxFit.cover,
        ),
        Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          drawerEnableOpenDragGesture: true,
          drawerScrimColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          key: scaffoldKey,
          endDrawer:
              isDrawerWidget ? appBackgroundScaffoldDrawer(context) : null,
          floatingActionButton: floatingActionButton,
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            height: responsiveHeight(context, 179),
            isChangeLang: isChangeLang,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
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
                // area for the child content (centered)
                Center(
                  child: Container(
                    height: MediaQuery.sizeOf(context).height,
                    padding: padding,
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
