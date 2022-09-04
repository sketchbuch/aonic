import '../actions/actions.dart';
import '../models/book_state.dart';

BookState bookStateReducer(BookState bookState, action) {
  if (action is LoadBookRequest) {
    return bookState.copyWith(status: BookStateStatus.loading);
  }

  if (action is LoadBookSuccess) {
    return bookState.copyWith(bookXml: action.xml, book: action.book, status: BookStateStatus.succeeded);
  }

  if (action is LoadBookFaliure) {
    const initialState = BookState.initialState();
    return initialState.copyWith(errorMessage: action.errorMessage, status: BookStateStatus.failed);
  }

  if (action is UnloadBookAction) {
    return const BookState.initialState();
  }

  return bookState;
}
