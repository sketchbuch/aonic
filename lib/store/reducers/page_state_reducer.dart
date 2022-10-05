import '../../constants/books.dart';
import '../actions/actions.dart';
import '../models/page_state.dart';

PageState pageStateReducer(PageState pageState, action) {
  if (action is NavigateAction) {
    if (action.route.startsWith(sectionPrefix)) {
      final sectionNumber = pageState.getSectionNumber(action.route);
      print(
          '### pageStateReducer(${action.route}) - section: "$sectionNumber"');
      return pageState.copyWith(
          pageId: action.route, sectionNumber: sectionNumber);
    } else {
      print('### pageStateReducer(${action.route}) - front/backmatter');
      return pageState.copyWith(pageId: action.route, sectionNumber: pageMin);
    }
  }

  return pageState;
}
