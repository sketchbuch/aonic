import 'package:redux/redux.dart';

import '../../../models/book/book.dart';
import '../../../store/models/app_state.dart';

class BookDisplayViewModel {
  final Book? book;
  final int page;

  BookDisplayViewModel({
    required this.book,
    required this.page,
  });

  factory BookDisplayViewModel.create(Store<AppState> store) {
    final state = store.state;
    final bookState = state.bookState;

    return BookDisplayViewModel(
      book: bookState.book,
      page: state.page,
    );
  }
}
