part of 'translation_cubit.dart';

@immutable
abstract class TranslationState {
  final Locale currentLocale;
  const TranslationState({required this.currentLocale});
}

class TranslationInitial extends TranslationState {
  const TranslationInitial({required super.currentLocale});
}

class TranslationLoading extends TranslationState {
  const TranslationLoading({required super.currentLocale});
}

class TranslationSuccess extends TranslationState {
  final String translatedText;
  const TranslationSuccess({
    required this.translatedText,
    required super.currentLocale,
  });
}

class TranslationFailure extends TranslationState {
  final String error;
  const TranslationFailure({
    required this.error,
    required super.currentLocale,
  });
}
