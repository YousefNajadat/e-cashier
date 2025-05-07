import 'package:e_cashier/core/constant/icons_path.dart';
import 'package:e_cashier/core/constant/images_path.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:e_cashier/core/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_cashier/core/constant/gifs_path.dart';
import 'package:gap/gap.dart';

class AppBackgroundScaffold extends StatelessWidget {
  final Widget child;
  final double topPadding;
  final double appNameHeight;
  final double appNameWidth;

  const AppBackgroundScaffold({
    super.key,
    required this.child,
    this.topPadding = 88,
    this.appNameHeight = 91,
    this.appNameWidth = 225,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Listener(
        onPointerDown: (_) => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        // Makes sure even empty areas register taps
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
            // Content column
            Column(
              children: [
                // App name at the top with padding
                Gap(responsiveHeight(context, topPadding)),
                Center(
                  child: svgWidget(
                    context,
                    ImagesPath.app_name,
                    appNameHeight,
                    appNameWidth,
                  ),
                ),

                // Expanded area for the child content (centered)
                Expanded(child: Center(child: child)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
