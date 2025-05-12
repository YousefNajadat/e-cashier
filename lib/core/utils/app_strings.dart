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

  String get please_enter_your_phone_number {
    return AppLocalizations.of(context)!.please_enter_your_phone_number;
  }

  String get phone_Number {
    return AppLocalizations.of(context)!.phone_Number;
  }

  String get kioskSettings {
    return AppLocalizations.of(context)!.kioskSettings;
  }

  String get check_for_updates {
    return AppLocalizations.of(context)!.check_for_updates;
  }

  String get version {
    return AppLocalizations.of(context)!.version;
  }

  String get employeeNumber {
    return AppLocalizations.of(context)!.employeeNumber;
  }

  String get enter_employee_number {
    return AppLocalizations.of(context)!.enter_employee_number;
  }

  String get password {
    return AppLocalizations.of(context)!.password;
  }

  String get enter_password {
    return AppLocalizations.of(context)!.enter_password;
  }

  String get confirm {
    return AppLocalizations.of(context)!.confirm;
  }

  String get requiredField {
    return AppLocalizations.of(context)!.requiredField;
  }

  String get passwordLength {
    return AppLocalizations.of(context)!.passwordLength;
  }

  String get passwordNumberValidation {
    return AppLocalizations.of(context)!.passwordNumberValidation;
  }

  String get serviceControls {
    return AppLocalizations.of(context)!.serviceControls;
  }

  String get branchSelection {
    return AppLocalizations.of(context)!.branchSelection;
  }

  String get signOut {
    return AppLocalizations.of(context)!.signOut;
  }

  String get back {
    return AppLocalizations.of(context)!.back;
  }

  String get serviceOrder {
    return AppLocalizations.of(context)!.serviceOrder;
  }

  String get vehicleOrder {
    return AppLocalizations.of(context)!.vehicleOrder;
  }

  String get sparePartsOrder {
    return AppLocalizations.of(context)!.sparePartsOrder;
  }

  String get promissoryNote {
    return AppLocalizations.of(context)!.promissoryNote;
  }

  String get please_go_back_and_change_branch {
    return AppLocalizations.of(context)!.please_go_back_and_change_branch;
  }
  String get invalid_branch_id {
    return AppLocalizations.of(context)!.invalid_branch_id;
  }
}
