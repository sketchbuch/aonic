import 'package:redux/redux.dart';

import '../../models/booklist/booklist_item.dart';
import '../../store/redux/actions/actions.dart';
import '../../store/redux/actions/load_book_action.dart';
import '../../store/redux/models/app_state.dart';
import '../../store/redux/models/book_state.dart';
import '../../types/types.dart';

class BookViewModel {
  final BooklistItem? selectedBook;
  final BookText bookTitle;
  final BookText sectionTitle;
  final bool canShowActionButton;
  final bool isBookLoaded;
  final bool isLoading;
  final bool isSection;
  final int sectionNumber;
  final String pageId;
  final void Function() onNextPage;
  final void Function() onPrevPage;
  final void Function() onUnloadBook;
  final void Function(BooklistItem) onLoadBook;

  BookViewModel({
    required this.bookTitle,
    required this.canShowActionButton,
    required this.isBookLoaded,
    required this.isLoading,
    required this.isSection,
    required this.onLoadBook,
    required this.onNextPage,
    required this.onPrevPage,
    required this.onUnloadBook,
    required this.pageId,
    required this.sectionNumber,
    required this.sectionTitle,
    required this.selectedBook,
  });

  factory BookViewModel.create(Store<AppState> store) {
    final state = store.state;
    final bookState = state.bookState;
    final pageState = state.pageState;
    final book = bookState.book;

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

    final currentSection = book?.getSection(pageState.pageId);

    return BookViewModel(
      bookTitle: book != null ? book.title : '',
      canShowActionButton: state.selectedBook != null && bookState.status != BookStateStatus.loading,
      isBookLoaded: bookState.status == BookStateStatus.succeeded,
      isLoading: bookState.status == BookStateStatus.loading,
      onLoadBook: onLoadBook,
      onNextPage: onNextPage,
      isSection: currentSection != null ? currentSection.isNumbered() : false,
      onPrevPage: onPrevPage,
      onUnloadBook: onUnloadBook,
      pageId: pageState.pageId,
      sectionNumber: pageState.sectionNumber,
      sectionTitle: currentSection != null ? currentSection.meta.title : '',
      selectedBook: state.selectedBook,
    );
  }
}
