import 'package:flutter/material.dart';

import '../../features/branch_selection/presentation/screens/branch_selection_screen.dart';
import '../../features/change_lang/presentation/screens/change_language_screen.dart';

class PageRoutes {
  static const branchSelection = '/branchSelection';
  static const changeLanguageScreen = '/changeLanguageScreen';

  String? get initialRoute {
    return PageRoutes.branchSelection;
  }

  Map<String, Widget Function(BuildContext)> get pageRoutes {
    return {
      PageRoutes.branchSelection: (context) => BranchSelection(),
      PageRoutes.changeLanguageScreen: (context) => ChangeLanguageScreen(),
    };
  }
}
