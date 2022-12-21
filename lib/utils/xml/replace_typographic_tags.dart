import '../../constants/characters.dart';

const Map<String, String> chTags = {
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

  chTags.forEach((key, value) {
    replacedStr = replacedStr.replaceAll(key, value);
  });

  return replacedStr;
}
