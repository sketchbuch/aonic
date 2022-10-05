import 'package:redux/redux.dart';

import '../../../models/book/book.dart';
import '../../../routes/routes.dart';
import '../../../store/actions/actions.dart';
import '../../../store/models/app_state.dart';
import '../../../types/types.dart';

class BookDisplayViewModel {
  final Book? book;
  final int page;
  final OnNavigate onNavigate;

  BookDisplayViewModel({
    required this.book,
    required this.onNavigate,
    required this.page,
  });

  factory BookDisplayViewModel.create(Store<AppState> store) {
    final state = store.state;
    final bookState = state.bookState;

    void onNavigate(String link) {
      store.dispatch(NavigateAction(bookNav, link));
    }

    return BookDisplayViewModel(
      book: bookState.book,
      onNavigate: onNavigate,
      page: state.page,
    );
  }
}
