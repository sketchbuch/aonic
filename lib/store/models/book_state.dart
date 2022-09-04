import 'package:flutter/material.dart';

import '../../models/book/book.dart';

enum BookStateStatus {
  failed,
  idle,
  loading,
  succeeded,
}

@immutable
class BookState {
  final Book? book;
  final BookStateStatus status;
  final String bookXml;
  final String errorMessage;

  const BookState({
    required this.book,
    required this.bookXml,
    required this.errorMessage,
    required this.status,
  });

  const BookState.initialState()
      : book = null,
        bookXml = '',
        errorMessage = '',
        status = BookStateStatus.idle;

  BookState copyWith({Book? book, String? bookXml, String? errorMessage, BookStateStatus? status}) => BookState(
        book: book ?? this.book,
        bookXml: bookXml ?? this.bookXml,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
      );
}
