import 'package:redux/redux.dart';

import '../../../models/booklist/booklist_item.dart';
import '../../../store/redux/actions/actions.dart';
import '../../../store/redux/models/app_state.dart';
import '../../../store/redux/models/book_state.dart';

class BookSelectionViewModel {
  final BooklistItem? selectedBook;
  final bool isLoading;
  final void Function(BooklistItem?) onSelectBook;

  BookSelectionViewModel({
    required this.isLoading,
    required this.onSelectBook,
    required this.selectedBook,
  });

  factory BookSelectionViewModel.create(Store<AppState> store) {
    final state = store.state;
    final bookState = state.bookState;

    void onSelectBook(BooklistItem? selectedBook) {
      store.dispatch(SelectBookAction(selectedBook));
    }

    return BookSelectionViewModel(
      isLoading: bookState.status == BookStateStatus.loading || bookState.status == BookStateStatus.succeeded,
      onSelectBook: onSelectBook,
      selectedBook: state.selectedBook,
    );
  }
}
