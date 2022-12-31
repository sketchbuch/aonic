import '../../constants/characters.dart';

/**
 * onomatopoeia = Sounds, these are normally rendered italic
 */
const Map<String, String> typographicTags = {
  '<ch.aacute/>': 'á',
  '<ch.ampersand/>': '&',
  '<ch.apos/>': endQuote,
  '<ch.auml/>': 'ä',
  '<ch.blankline/>': '_______',
  '<ch.copy/>': '©',
  '<ch.eacute/>': 'é',
  '<ch.ellips/>': '…',
  '<ch.emdash/>': '—',
  '<ch.endash/>': '–',
  '<ch.lellips/>': '…',
  '<ch.minus/>': '−',
  '<ch.ouml/>': 'ö',
  '<ch.plus/>': '+',
  '<ch.uuml/>': 'ü',
  '<quote>': startQuote,
  '</quote>': endQuote,
};

String replaceTypographicTags(String xmlString) {
  String replacedStr = xmlString;

  typographicTags.forEach((key, value) {
    replacedStr = replacedStr.replaceAll(key, value);
  });

  return replacedStr;
}
