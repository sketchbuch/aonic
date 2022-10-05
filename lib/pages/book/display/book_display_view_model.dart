import 'package:redux/redux.dart';

import '../../../models/book/book.dart';
import '../../../routes/routes.dart';
import '../../../store/actions/actions.dart';
import '../../../store/models/app_state.dart';
import '../../../types/types.dart';

class BookDisplayViewModel {
  final Book book;
  final bool isMatter;
  final bool isSection;
  final int sectionNumber;
  final OnNavigate onNavigate;
  final String pageId;

  BookDisplayViewModel({
    required this.book,
    required this.isMatter,
    required this.isSection,
    required this.onNavigate,
    required this.pageId,
    required this.sectionNumber,
  });

  factory BookDisplayViewModel.create(Store<AppState> store) {
    final state = store.state;
    final bookState = state.bookState;
    final pageState = state.pageState;

    void onNavigate(String link) {
      store.dispatch(PageNavigateAction(bookNav, link));
    }

    return BookDisplayViewModel(
      book: bookState.book!,
      isMatter: pageState.isMatter(),
      isSection: pageState.isSection(),
      onNavigate: onNavigate,
      pageId: pageState.pageId,
      sectionNumber: pageState.sectionNumber,
    );
  }
}
