import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../../../core/constant/app_constant.dart';
import '../../../../../core/data/local/storage_helper.dart';
part 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  TranslationCubit() : super(const TranslationInitial(currentLocale: Locale('en')));

  void toggleLanguage() async{
    final currentLang = state.currentLocale.languageCode;
    final newLocale = currentLang == LanguageLocalCodes.english.toString()
        ? LanguageLocalCodes.arabic
        : LanguageLocalCodes.english;
    print(newLocale.toString());
    await StorageHelper.setLang(newLocale.toString());
    emit(TranslationInitial(currentLocale: newLocale));
  }

  void changeLanguage(String languageCode) {
    emit(TranslationInitial(currentLocale: Locale(languageCode)));
  }

  void setLanguage() async {
    String? langCode =  StorageHelper.getLang();
    String languageCode;
    if (langCode == null) {
      languageCode = LanguageLocalCodes.english.toString();
    } else {
      languageCode = langCode;
    }
    if (langCode != state.currentLocale.toString() &&
        languageCode != state.currentLocale.toString()) {
      print('inside setLanguage()');
      emit(TranslationInitial(currentLocale: Locale(languageCode)));
    }
  }

  void setToArabic() {
    emit(TranslationInitial(currentLocale: Locale('ar')));
    StorageHelper.setLang('ar');
  }

  void setToEnglish() {
    emit(TranslationInitial(currentLocale: Locale('en')));
    StorageHelper.setLang('en');
  }
}
