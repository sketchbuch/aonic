class BookXmlException implements Exception {
  String message;

  BookXmlException(this.message);

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}

class ContentXmlException implements Exception {
  String message;

  ContentXmlException(this.message);

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}

class XmlCleaningException implements Exception {
  String message;

  XmlCleaningException(this.message);

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}
