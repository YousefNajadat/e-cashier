import 'package:flutter/material.dart';

import '../../features/branch_selection/presentation/screens/branch_selection_screen.dart';

class PageRoutes {
  static const branchSelection = '/branchSelection';

  String? get initialRoute {
    return PageRoutes.branchSelection;
  }

  Map<String, Widget Function(BuildContext)> get pageRoutes {
    return {PageRoutes.branchSelection: (context) => BranchSelection()};
  }
}
