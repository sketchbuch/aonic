import 'package:redux/redux.dart';

import '../../../models/booklist/booklist_item.dart';
import '../../../store/actions/actions.dart';
import '../../../store/models/app_state.dart';

class BookSelectionViewModel {
  final BooklistItem? selectedBook;
  final void Function(BooklistItem?) onSelectBook;

  BookSelectionViewModel({
    required this.onSelectBook,
    required this.selectedBook,
  });

  factory BookSelectionViewModel.create(Store<AppState> store) {
    final state = store.state;

    void _onSelectBook(BooklistItem? selectedBook) {
      store.dispatch(SelectBookAction(selectedBook));
    }

    return BookSelectionViewModel(
      onSelectBook: _onSelectBook,
      selectedBook: state.selectedBook,
    );
  }
}
