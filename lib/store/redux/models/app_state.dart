import 'package:flutter/material.dart';

import '../../../models/booklist/booklist_item_model.dart';
import 'action_chart_state.dart';
import 'book_state.dart';
import 'page_state.dart';

@immutable
class AppState {
  final ActionChartState actionChartState;
  final BooklistItemModel? selectedBook;
  final BookState bookState;
  final PageState pageState;

  const AppState({
    required this.actionChartState,
    required this.bookState,
    required this.pageState,
    required this.selectedBook,
  });

  const AppState.initialState()
      : actionChartState = const ActionChartState.initialState(),
        bookState = const BookState.initialState(),
        pageState = const PageState.initialState(),
        selectedBook = null;

  AppState copyWith({
    ActionChartState? actionChartState,
    BooklistItemModel? selectedBook,
    BookState? bookState,
    PageState? pageState,
  }) =>
      AppState(
        actionChartState: actionChartState ?? this.actionChartState,
        bookState: bookState ?? this.bookState,
        pageState: pageState ?? this.pageState,
        selectedBook: selectedBook ?? this.selectedBook,
      );
}
