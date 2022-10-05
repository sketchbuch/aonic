import '../../constants/books.dart';
import '../actions/actions.dart';
import '../models/page_state.dart';

PageState pageStateReducer(PageState pageState, action) {
  if (action is NavigateAction) {
    if (action.route.startsWith(sectionPrefix)) {
      final sectionNumber = pageState.getSectionNumber(action.route);
      return pageState.copyWith(
          pageId: action.route, sectionNumber: sectionNumber);
    } else {
      return pageState.copyWith(pageId: action.route, sectionNumber: pageMin);
    }
  }

  return pageState;
}
