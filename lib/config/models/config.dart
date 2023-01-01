import 'package:collection/collection.dart';

import '../../types/types.dart';
import 'book_config.dart';

class Config {
  List<BookConfig> books = [];

  Config();

  void setBookData(BookConfigData bookConfigData) {
    for (var bookConfig in bookConfigData) {
      books.add(BookConfig(bookConfig));
    }
  }

  Json toJson() => {
        "books": books.map((book) => book.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  BookConfig? getBookByCode(String code) {
    return books.firstWhereOrNull((bookConfig) => bookConfig.code == code);
  }
}
