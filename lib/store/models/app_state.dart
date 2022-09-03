import 'package:flutter/material.dart';

import '../../models/book/book.dart';
import '../../models/booklist/booklist_item.dart';

@immutable
class AppState {
  final Book? book;
  final BooklistItem? selectedBook;
  final bool bookLoaded;
  final int page;
  final String bookXml;

  const AppState({
    required this.book,
    required this.bookLoaded,
    required this.bookXml,
    required this.page,
    required this.selectedBook,
  });

  const AppState.initialState()
      : book = null,
        bookLoaded = false,
        bookXml = '',
        page = 0,
        selectedBook = null;

  AppState copyWith({bool? bookLoaded, String? bookXml, int? page, BooklistItem? selectedBook, Book? book}) => AppState(
        book: book ?? this.book,
        bookLoaded: bookLoaded ?? this.bookLoaded,
        bookXml: bookXml ?? this.bookXml,
        page: page ?? this.page,
        selectedBook: selectedBook ?? this.selectedBook,
      );
}

class BookLoadedAction {
  final Book book;
  final bool isLoaded = true;
  final int page = 0;
  final String xml;

  BookLoadedAction(this.xml, this.book);
}

class BookUnloadedAction {
  final Book? book = null;
  final bool isLoaded = false;
  final int page = 0;
  final String xml = '';

  BookUnloadedAction();
}

class NextPageAction {
  NextPageAction();
}

class PrevPageAction {
  PrevPageAction();
}

class GoToPageAction {
  final int page;

  GoToPageAction(this.page);
}

class SelectBookAction {
  final BooklistItem? book;

  SelectBookAction(this.book);
}

AppState reducer(AppState state, action) {
  if (action is BookLoadedAction) {
    return state.copyWith(bookLoaded: action.isLoaded, bookXml: action.xml, page: action.page, book: action.book);
  } else if (action is BookUnloadedAction) {
    return state.copyWith(bookLoaded: action.isLoaded, bookXml: action.xml, page: action.page, book: action.book);
  } else if (action is GoToPageAction) {
    return state.copyWith(page: action.page);
  } else if (action is PrevPageAction) {
    final int newPage = state.page - 1;
    return state.copyWith(page: newPage < 0 ? 349 : newPage);
  } else if (action is NextPageAction) {
    final int newPage = state.page + 1;
    return state.copyWith(page: newPage > 349 ? 0 : newPage);
  } else if (action is SelectBookAction) {
    return state.copyWith(selectedBook: action.book);
  }

  return state;
}
