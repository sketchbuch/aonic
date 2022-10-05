import 'package:flutter/material.dart';

import '../../constants/books.dart';
import '../../models/booklist/booklist_item.dart';
import 'book_state.dart';
import 'page_state.dart';

@immutable
class AppState {
  final BookState bookState;
  final BooklistItem? selectedBook;
  final PageState pageState;

  const AppState({
    required this.bookState,
    required this.selectedBook,
    required this.pageState,
  });

  const AppState.initialState()
      : bookState = const BookState.initialState(),
        pageState = const PageState.initialState(),
        selectedBook = null;

  AppState copyWith(
          {BookState? bookState,
          int? page,
          PageState? pageState,
          BooklistItem? selectedBook}) =>
      AppState(
        bookState: bookState ?? this.bookState,
        pageState: pageState ?? this.pageState,
        selectedBook: selectedBook ?? this.selectedBook,
      );
}
