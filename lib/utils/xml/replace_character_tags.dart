const Map<String, String> chTags = {
  'aacute': 'á',
  'ampersand': '&',
  'apos': '’',
  'auml': 'ä',
  'blankline': '_______',
  'copy': '©',
  'eacute': 'é',
  'ellips': '…',
  'emdash': '—',
  'endash': '–',
  'lellips': '…',
  'minus': '−',
  'ouml': 'ö',
  'plus': '+',
  'uuml': 'ü',
};

String replaceCharacterTags(String xmlString) {
  var replacedStr = xmlString;

  chTags.forEach((key, value) {
    replacedStr = replacedStr.replaceAll('<ch.$key/>', value);
  });

  return replacedStr;
}
