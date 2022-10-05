import 'package:redux/redux.dart';

import '../../models/booklist/booklist_item.dart';
import '../../store/actions/actions.dart';
import '../../store/actions/load_book_action.dart';
import '../../store/models/app_state.dart';
import '../../store/models/book_state.dart';

class BookViewModel {
  final BooklistItem? selectedBook;
  final bool canShowActionButton;
  final bool isBookLoaded;
  final bool isLoading;
  final int sectionNumber;
  final String pageId;
  final void Function() onNextPage;
  final void Function() onPrevPage;
  final void Function() onUnloadBook;
  final void Function(BooklistItem) onLoadBook;

  BookViewModel({
    required this.canShowActionButton,
    required this.isBookLoaded,
    required this.isLoading,
    required this.onLoadBook,
    required this.onNextPage,
    required this.onPrevPage,
    required this.onUnloadBook,
    required this.pageId,
    required this.sectionNumber,
    required this.selectedBook,
  });

  factory BookViewModel.create(Store<AppState> store) {
    final state = store.state;
    final bookState = state.bookState;
    final pageState = state.pageState;

    void onNextPage() {
      store.dispatch(NextPageAction());
    }

    void onPrevPage() {
      store.dispatch(PrevPageAction());
    }

    void onLoadBook(BooklistItem selectedBook) {
      store.dispatch(loadBookAction(selectedBook));
    }

    void onUnloadBook() {
      store.dispatch(UnloadBookAction());
    }

    return BookViewModel(
      canShowActionButton: state.selectedBook != null &&
          bookState.status != BookStateStatus.loading,
      isBookLoaded: bookState.status == BookStateStatus.succeeded,
      isLoading: bookState.status == BookStateStatus.loading,
      onLoadBook: onLoadBook,
      onNextPage: onNextPage,
      onPrevPage: onPrevPage,
      onUnloadBook: onUnloadBook,
      pageId: pageState.pageId,
      sectionNumber: pageState.sectionNumber,
      selectedBook: state.selectedBook,
    );
  }
}
