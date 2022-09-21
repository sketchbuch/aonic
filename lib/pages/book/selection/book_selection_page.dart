import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../constants/books.dart';
import '../../../i18n/_generated_/translations.g.dart';
import '../../../models/booklist/booklist.dart';
import '../../../store/models/app_state.dart';
import '../../../widgets/book_selection.dart';
import 'book_selection_view_model.dart';

class BookSelectionPage extends StatelessWidget {
  final booklist = Booklist(t.booksLonewolf.books, lonewolfSupportedBooks, 'en').getBooks();

  BookSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookSelectionViewModel>(
      converter: (store) => BookSelectionViewModel.create(store),
      builder: (BuildContext context, BookSelectionViewModel viewModel) {
        return Scaffold(
          body: Center(
            child: viewModel.isLoading
                ? const CircularProgressIndicator()
                : BookSelection(booklist, viewModel.selectedBook, viewModel.onSelectBook),
          ),
        );
      },
    );
  }
}
