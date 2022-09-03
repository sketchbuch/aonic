import '../../constants/books.dart';
import '../../exceptions/redux.dart';
import '../actions/actions.dart';

int pageReducer(int page, action) {
  if (action is GoToPageAction) {
    if (action.page < pageMin || action.page > pageMax) {
      throw ReducerException('Page out of bounds: "${action.page}"');
    }

    return action.page;
  }

  if (action is PrevPageAction) {
    final int newPage = page - 1;
    return newPage < pageMin ? pageMax : newPage;
  }

  if (action is NextPageAction) {
    final int newPage = page + 1;
    return newPage > pageMax ? pageMin : newPage;
  }

  if (action is BookUnloadedAction) {
    return pageMin;
  }

  return page;
}
