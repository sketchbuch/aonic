import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:xml/xml.dart';

import '../constants/books.dart';
import '../exceptions/xml.dart';
import '../i18n/_generated_/translations.g.dart';
import '../models/book/book.dart';
import '../models/booklist/booklist.dart';
import '../store/models/app_state.dart';
import '../utils/get_aon_book_data.dart';
import '../utils/xml/helpers.dart';
import '../widgets/book_display.dart';
import '../widgets/book_selection.dart';
import 'home_view_model.dart';

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
    return StoreConnector<AppState, HomeViewModel>(
      converter: (store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel viewModel) {
        final isBookLoaded = viewModel.bookState.bookLoaded;
        final book = viewModel.bookState.book;

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
