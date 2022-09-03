import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:xml/xml.dart';

import '../constants/supported_books.dart';
import '../exceptions/xml.dart';
import '../i18n/_generated_/translations.g.dart';
import '../models/book/book.dart';
import '../models/booklist/booklist.dart';
import '../models/booklist/booklist_item.dart';
import '../store/models/app_state.dart';
import '../utils/get_aon_book_data.dart';
import '../utils/xml/helpers.dart';
import '../widgets/book_display.dart';
import '../widgets/book_selection.dart';

class HomePage extends StatelessWidget {
  final String title;
  final booklist = Booklist(t.booksLonewolf.books, lonewolfSupportedBooks, 'en').getBooks();
  final trans = t.home;

  HomePage({Key? key, required this.title}) : super(key: key);

  void _handleBookLoad(HomeViewModel viewModel) async {
    final selectedBook = viewModel.selectedBook;

    if (selectedBook != null) {
      final bookData = await getAonBookData(selectedBook);
      final bookXml = XmlDocument.parse(cleanXmlString(bookData));
      final gamebook = bookXml.getElement('gamebook');

      if (gamebook != null) {
        Book book = Book.fromXml(gamebook);
        viewModel.onBookLoaded(bookData, book);
      } else {
        throw BookXmlException('Book data does not contain a "gamebook" element');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //final trans = t.home;

    return StoreConnector<AppState, HomeViewModel>(
      converter: (store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel viewModel) {
        final isBookLoaded = viewModel.bookLoaded;
        final book = viewModel.book;

        return Scaffold(
          appBar: AppBar(
            actions: isBookLoaded
                ? [
                    IconButton(
                      icon: const Icon(Icons.navigate_before),
                      tooltip: 'Previous',
                      onPressed: viewModel.onPrevPage,
                    ),
                    IconButton(
                      icon: const Icon(Icons.navigate_next),
                      tooltip: 'Next',
                      onPressed: viewModel.onNextPage,
                    ),
                  ]
                : [],
            title: Text(title),
          ),
          body: Center(
            child: isBookLoaded && book != null
                ? BookDisplay(book, viewModel.page)
                : BookSelection(booklist, viewModel.selectedBook, viewModel.onSelectBook),
          ),
          floatingActionButton: viewModel.selectedBook != null
              ? FloatingActionButton(
                  onPressed: () {
                    if (isBookLoaded) {
                      viewModel.onBookUnloaded();
                    } else {
                      _handleBookLoad(viewModel);
                    }
                  },
                  tooltip: isBookLoaded ? trans.loadButton.unload : trans.loadButton.load,
                  child: Icon(isBookLoaded ? Icons.home : Icons.download),
                )
              : null,
        );
      },
    );
  }
}

class HomeViewModel {
  final Book? book;
  final BooklistItem? selectedBook;
  final bool bookLoaded;
  final Function() onBookUnloaded;
  final Function() onNextPage;
  final Function() onPrevPage;
  final Function(BooklistItem?) onSelectBook;
  final Function(int) onGoToPage;
  final Function(String, Book) onBookLoaded;
  final int page;
  final String bookXml;

  HomeViewModel({
    required this.book,
    required this.bookLoaded,
    required this.bookXml,
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
      book: state.book,
      bookLoaded: state.bookLoaded,
      bookXml: state.bookXml,
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
