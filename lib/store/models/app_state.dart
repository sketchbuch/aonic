import 'package:flutter/material.dart';

import '../../constants/books.dart';
import '../../models/booklist/booklist_item.dart';
import 'book_state.dart';

@immutable
class AppState {
  final BookState bookState;
  final BooklistItem? selectedBook;
  final int page;

  const AppState({
    required this.bookState,
    required this.page,
    required this.selectedBook,
  });

  const AppState.initialState()
      : bookState = const BookState.initialState(),
        page = pageMin,
        selectedBook = null;

  AppState copyWith(
          {BookState? bookState, int? page, BooklistItem? selectedBook}) =>
      AppState(
        bookState: bookState ?? this.bookState,
        page: page ?? this.page,
        selectedBook: selectedBook ?? this.selectedBook,
      );
}
