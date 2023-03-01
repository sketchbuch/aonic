import '../../../models/booklist/booklist_item_model.dart';
import '../actions/actions.dart';

BooklistItemModel? selectedBookReducer(BooklistItemModel? book, action) {
  if (action is SelectBookAction) {
    return action.book;
  }

  if (action is LoadBookFaliure || action is UnloadBookAction) {
    return null;
  }

  return book;
}
