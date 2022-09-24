import 'package:redux/redux.dart';

import '../../../models/book/book.dart';
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

    void _onNavigate(String link) {
      print('### Link: "$link"');
      // store.dispatch(NavigateAction(bookNav, bookNumberedRoute));
    }

    return BookDisplayViewModel(
      book: bookState.book,
      onNavigate: _onNavigate,
      page: state.page,
    );
  }
}
