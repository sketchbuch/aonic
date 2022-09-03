import 'package:redux/redux.dart';

import '../models/book/book.dart';
import '../models/booklist/booklist_item.dart';
import '../store/actions/actions.dart';
import '../store/models/app_state.dart';
import '../store/models/book_state.dart';

class HomeViewModel {
  final BookState bookState;
  final BooklistItem? selectedBook;
  final Function() onBookUnloaded;
  final Function() onNextPage;
  final Function() onPrevPage;
  final Function(BooklistItem?) onSelectBook;
  final Function(int) onGoToPage;
  final Function(String, Book) onBookLoaded;
  final int page;

  HomeViewModel({
    required this.bookState,
    required this.onBookLoaded,
    required this.onBookUnloaded,
    required this.onGoToPage,
    required this.onNextPage,
    required this.onPrevPage,
    required this.onSelectBook,
    required this.page,
    required this.selectedBook,
  });

  factory HomeViewModel.create(Store<AppState> store) {
    final state = store.state;

    void _onBookLoaded(String bookXml, Book book) {
      store.dispatch(BookLoadedAction(bookXml, book));
    }

    void _onBookUnloaded() {
      store.dispatch(BookUnloadedAction());
    }

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

    return HomeViewModel(
      bookState: state.bookState,
      onBookLoaded: _onBookLoaded,
      onBookUnloaded: _onBookUnloaded,
      onGoToPage: _onGoToPage,
      onNextPage: _onNextPage,
      onPrevPage: _onPrevPage,
      onSelectBook: _onSelectBook,
      page: state.page,
      selectedBook: state.selectedBook,
    );
  }
}
