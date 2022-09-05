import '../models/app_state.dart';
import 'book_state_reducer.dart';
import 'page_reducer.dart';
import 'selected_book_reducer.dart';

AppState appStateReducer(
  AppState state,
  action,
) {
  return AppState(
    bookState: bookStateReducer(state.bookState, action),
    page: pageReducer(state.page, action),
    selectedBook: selectedBookReducer(state.selectedBook, action),
  );
}