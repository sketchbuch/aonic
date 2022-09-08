import 'package:redux/redux.dart';

import '../../../models/book/book.dart';
import '../../../models/booklist/booklist_item.dart';
import '../../../store/actions/actions.dart';
import '../../../store/actions/thunk_actions.dart';
import '../../../store/models/app_state.dart';
import '../../../store/models/book_state.dart';

class BookViewModel {
  final Book? book;
  final BooklistItem? selectedBook;
  final bool isBookLoaded;
  final bool isError;
  final bool isIdle;
  final bool isLoading;
  final int page;
  final String bookErrorMessage;
  final void Function() onNextPage;
  final void Function() onPrevPage;
  final void Function() onUnloadBook;
  final void Function(BooklistItem?) onSelectBook;
  final void Function(BooklistItem) onLoadBook;
  final void Function(int) onGoToPage;

  BookViewModel({
    required this.book,
    required this.bookErrorMessage,
    required this.isBookLoaded,
    required this.isError,
    required this.isIdle,
    required this.isLoading,
    required this.onGoToPage,
    required this.onLoadBook,
    required this.onNextPage,
    required this.onPrevPage,
    required this.onSelectBook,
    required this.onUnloadBook,
    required this.page,
    required this.selectedBook,
  });

  factory BookViewModel.create(Store<AppState> store) {
    final state = store.state;
    final bookState = state.bookState;

    void _onNextPage() {
      store.dispatch(NextPageAction());
    }

    void _onPrevPage() {
      store.dispatch(PrevPageAction());
    }

    void _onGoToPage(int page) {
      store.dispatch(GoToPageAction(page));
    }

    void _onSelectBook(BooklistItem? selectedBook) {
      store.dispatch(SelectBookAction(selectedBook));
    }

    void _onLoadBook(BooklistItem selectedBook) {
      store.dispatch(loadBookAction(selectedBook));
    }

    void _onUnloadBook() {
      store.dispatch(UnloadBookAction());
    }

    return BookViewModel(
      book: bookState.book,
      bookErrorMessage: bookState.errorMessage,
      isBookLoaded: bookState.status == BookStateStatus.succeeded,
      isError: bookState.status == BookStateStatus.failed,
      isIdle: bookState.status == BookStateStatus.idle,
      isLoading: bookState.status == BookStateStatus.loading,
      onGoToPage: _onGoToPage,
      onLoadBook: _onLoadBook,
      onNextPage: _onNextPage,
      onPrevPage: _onPrevPage,
      onSelectBook: _onSelectBook,
      onUnloadBook: _onUnloadBook,
      page: state.page,
      selectedBook: state.selectedBook,
    );
  }
}
