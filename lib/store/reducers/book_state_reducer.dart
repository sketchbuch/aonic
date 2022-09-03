import '../actions/actions.dart';
import '../models/book_state.dart';

BookState bookStateReducer(BookState bookState, action) {
  if (action is BookLoadedAction) {
    return bookState.copyWith(bookLoaded: action.isLoaded, bookXml: action.xml, book: action.book);
  }

  if (action is BookUnloadedAction) {
    return const BookState.initialState();
  }

  return bookState;
}
