import '../../../constants/books.dart';
import '../actions/actions.dart';
import '../models/page_state.dart';

PageState pageStateReducer(PageState pageState, action) {
  if (action is PageNavigateAction) {
    if (pageState.isSectionLink(action.route)) {
      final sectionNumber = pageState.getSectionNumber(action.route);
      return pageState.copyWith(
        pageId: action.route,
        sectionNumber: sectionNumber,
      );
    } else {
      return pageState.copyWith(
        pageId: action.route,
        sectionNumber: pageDefault,
      );
    }
  } else if (action is LoadBookSuccess) {
    const initialState = PageState.initialState();
    return initialState.copyWith(
      pageId: bookIdToc,
    );
  } else if (action is LoadBookFaliure) {
    return const PageState.initialState();
  }

  return pageState;
}
