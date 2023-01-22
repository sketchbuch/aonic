import '../models/app_state.dart';
import 'action_chart_state_reducer.dart';
import 'book_state_reducer.dart';
import 'page_state_reducer.dart';
import 'selected_book_reducer.dart';

AppState appStateReducer(
  AppState state,
  action,
) {
  return AppState(
    actionChartState: actionChartStateReducer(state.actionChartState, action),
    bookState: bookStateReducer(state.bookState, action),
    pageState: pageStateReducer(state.pageState, action),
    selectedBook: selectedBookReducer(state.selectedBook, action),
  );
}
