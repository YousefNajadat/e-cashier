import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppStrings {
  final BuildContext context;

  AppStrings({required this.context});

  String get lang {
    return AppLocalizations.of(context)!.lang;
  }

  String get local {
    return AppLocalizations.of(context)!.local;
  }

  String get pleaseChooseTheLanguage {
    return AppLocalizations.of(context)!.please_choose_the_language;
  }

  String get pleaseChooseTheLanguageArabic {
    return AppLocalizations.of(context)!.please_choose_the_language_arabic;
  }

  String get pleaseChooseTheBranch {
    return AppLocalizations.of(context)!.please_choose_the_branch;
  }

  String get chooseValue {
    return AppLocalizations.of(context)!.choose_value;
  }
  String get singIn {
    return AppLocalizations.of(context)!.singIn;
  }
}
