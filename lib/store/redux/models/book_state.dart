import 'package:flutter/material.dart';

import '../../../models/book/book.dart';

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
  final int bookNumber;
  final String bookCode;
  final String bookXml;
  final String errorMessage;

  const BookState({
    required this.book,
    required this.bookCode,
    required this.bookNumber,
    required this.bookXml,
    required this.errorMessage,
    required this.status,
  });

  const BookState.initialState()
      : book = null,
        bookCode = '',
        bookNumber = -1,
        bookXml = '',
        errorMessage = '',
        status = BookStateStatus.idle;

  BookState copyWith({
    Book? book,
    BookStateStatus? status,
    int? bookNumber,
    String? bookCode,
    String? bookXml,
    String? errorMessage,
  }) =>
      BookState(
        book: book ?? this.book,
        bookCode: bookCode ?? this.bookCode,
        bookNumber: bookNumber ?? this.bookNumber,
        bookXml: bookXml ?? this.bookXml,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
      );
}
