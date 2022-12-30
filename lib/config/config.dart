import 'package:collection/collection.dart';

import '../types/types.dart';
import 'book_config.dart';
import 'book_data.dart';

class Config {
  List<BookConfig> books = [];

  Config(BookConfigItems bookConfig) {
    for (var book in bookConfig) {
      books.add(BookConfig(book));
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

final config = Config(bookdata);
