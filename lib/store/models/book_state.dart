import 'package:flutter/material.dart';

import '../../models/book/book.dart';

@immutable
class BookState {
  final Book? book;
  final bool bookLoaded;
  final String bookXml;

  const BookState({
    required this.book,
    required this.bookLoaded,
    required this.bookXml,
  });

  const BookState.initialState()
      : book = null,
        bookLoaded = false,
        bookXml = '';

  BookState copyWith({Book? book, bool? bookLoaded, String? bookXml}) => BookState(
        book: book ?? this.book,
        bookLoaded: bookLoaded ?? this.bookLoaded,
        bookXml: bookXml ?? this.bookXml,
      );
}
