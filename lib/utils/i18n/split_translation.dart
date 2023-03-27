import '../../types/types.dart';

/// Splits a translation string. Needed to get round https://github.com/Tienisto/slang/issues/128
List<String> splitTranslation(TranslatedText text) {
  if (text.isEmpty) {
    return [];
  }

  return text.split('|');
}