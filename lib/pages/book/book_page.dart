import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants/books.dart';
import '../../i18n/_generated_/translations.g.dart';
import '../../models/booklist/booklist.dart';
import '../../store/models/app_state.dart';
import '../../widgets/book_display.dart';
import '../../widgets/book_selection.dart';
import 'book_view_model.dart';

class BookPage extends StatelessWidget {
  final booklist = Booklist(t.booksLonewolf.books, lonewolfSupportedBooks, 'en').getBooks();
  final transCommon = t.common;
  final transBook = t.book;

  BookPage({Key? key}) : super(key: key);

  void _handleBookLoad(BookViewModel viewModel) async {
    final selectedBook = viewModel.selectedBook;

    if (selectedBook != null) {
      viewModel.onLoadBook(selectedBook);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookViewModel>(
      converter: (store) => BookViewModel.create(store),
      builder: (BuildContext context, BookViewModel viewModel) {
        final book = viewModel.book;
        final page = viewModel.page;

        var titleText = transBook.titleSelection;
        var tooltipText = transBook.loadButton.load;

        if (viewModel.isLoading) {
          titleText = transBook.titleLoading;
        } else if (viewModel.isBookLoaded) {
          titleText = transBook.title;
          tooltipText = transBook.loadButton.unload;
        }

        return Scaffold(
          appBar: AppBar(
            actions: viewModel.isBookLoaded
                ? [
                    IconButton(
                      icon: const Icon(Icons.navigate_before),
                      onPressed: page > pageMin ? viewModel.onPrevPage : null,
                      tooltip: transCommon.prev,
                    ),
                    IconButton(
                      icon: const Icon(Icons.navigate_next),
                      onPressed: page < pageMax ? viewModel.onNextPage : null,
                      tooltip: transCommon.next,
                    ),
                  ]
                : [],
            title: Text(titleText),
          ),
          body: Center(
            child: viewModel.isBookLoaded && book != null
                ? BookDisplay(book, page)
                : viewModel.isLoading
                    ? const CircularProgressIndicator()
                    : BookSelection(booklist, viewModel.selectedBook, viewModel.onSelectBook),
          ),
          floatingActionButton: viewModel.selectedBook != null && !viewModel.isLoading
              ? FloatingActionButton(
                  onPressed: () {
                    if (viewModel.isBookLoaded) {
                      viewModel.onUnloadBook();
                    } else {
                      _handleBookLoad(viewModel);
                    }
                  },
                  tooltip: tooltipText,
                  child: Icon(viewModel.isBookLoaded ? Icons.home : Icons.download),
                )
              : null,
        );
      },
    );
  }
}
