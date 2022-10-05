import '../../constants/books.dart';
import '../actions/actions.dart';
import '../models/page_state.dart';

PageState pageStateReducer(PageState pageState, action) {
  if (action is PageNavigateAction) {
    if (pageState.isSectionLink(action.route)) {
      final sectionNumber = pageState.getSectionNumber(action.route);
      print(
          '### pageStateReducer(${action.route}) - section: "$sectionNumber"');
      return pageState.copyWith(
          pageId: action.route, sectionNumber: sectionNumber);
    } else {
      print('### pageStateReducer(${action.route}) - front/backmatter');
      return pageState.copyWith(pageId: action.route, sectionNumber: pageMin);
    }
  } else if (action is LoadBookSuccess) {
    const initialState = PageState.initialState();
    return initialState.copyWith(pageId: bookStartPage);
  } else if (action is LoadBookFaliure) {
    return const PageState.initialState();
  }

  return pageState;
}
