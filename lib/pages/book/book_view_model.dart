import 'package:redux/redux.dart';

import '../../models/booklist/booklist_item_model.dart';
import '../../store/redux/actions/action_chart.dart';
import '../../store/redux/actions/actions.dart';
import '../../store/redux/actions/load_book_action.dart';
import '../../store/redux/models/app_state.dart';
import '../../store/redux/models/book_state.dart';
import '../../types/types.dart';

class BookViewModel {
  final BooklistItemModel? selectedBook;
  final BookText bookTitle;
  final BookText sectionTitle;
  final bool canShowActionButton;
  final bool isActionChartVisible;
  final bool isBookLoaded;
  final bool isLoading;
  final bool isSection;
  final int sectionNumber;
  final String pageId;
  final void Function(bool isVisible) onActionChartClick;
  final void Function() onNextPage;
  final void Function() onPrevPage;
  final void Function() onUnloadBook;
  final void Function(BooklistItemModel) onLoadBook;

  BookViewModel({
    required this.bookTitle,
    required this.canShowActionButton,
    required this.isActionChartVisible,
    required this.isBookLoaded,
    required this.isLoading,
    required this.isSection,
    required this.onActionChartClick,
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
    final actionChartState = state.actionChartState;
    final bookState = state.bookState;
    final pageState = state.pageState;
    final book = bookState.book;

    void onNextPage() {
      store.dispatch(NextPageAction());
    }

    void onPrevPage() {
      store.dispatch(PrevPageAction());
    }

    void onLoadBook(BooklistItemModel selectedBook) {
      store.dispatch(loadBookAction(selectedBook));
    }

    void onUnloadBook() {
      store.dispatch(UnloadBookAction());
    }

    void onActionChartClick(bool isVisible) {
      if (isVisible) {
        store.dispatch(ActionChartClose());
      } else {
        store.dispatch(ActionChartOpen());
      }
    }

    final currentSection = book?.getSection(pageState.pageId);

    return BookViewModel(
      isActionChartVisible: actionChartState.isVisible,
      bookTitle: book != null ? book.title : '',
      canShowActionButton: state.selectedBook != null &&
          bookState.status != BookStateStatus.loading,
      isBookLoaded: bookState.status == BookStateStatus.succeeded,
      isLoading: bookState.status == BookStateStatus.loading,
      isSection: currentSection != null ? currentSection.isNumbered() : false,
      onActionChartClick: onActionChartClick,
      onLoadBook: onLoadBook,
      onNextPage: onNextPage,
      onPrevPage: onPrevPage,
      onUnloadBook: onUnloadBook,
      pageId: pageState.pageId,
      sectionNumber: pageState.sectionNumber,
      sectionTitle: currentSection != null ? currentSection.meta.title : '',
      selectedBook: state.selectedBook,
    );
  }
}
