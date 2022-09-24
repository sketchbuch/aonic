String replaceIncludeLinks(String xmlString, Map<String, String> includeLinks) {
  var replacedStr = xmlString;

  includeLinks.forEach((key, value) {
    replacedStr = replacedStr.replaceAll('&link.$key;', value);
  });

  return replacedStr;
}
