import '../../models/booklist/booklist_item.dart';
import '../actions/actions.dart';

BooklistItem? selectedBookReducer(BooklistItem? book, action) {
  if (action is SelectBookAction) {
    return action.book;
  }

  if (action is BookUnloadedAction) {
    return null;
  }

  return book;
}
