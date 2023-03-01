import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../../constants/books.dart';
import '../../../../i18n/_generated_/translations.g.dart';
import '../../../../models/booklist/booklist_model.dart';
import '../../../../store/redux/models/app_state.dart';
import '../../../../widgets/page/book_selection.dart';
import 'book_selection_view_model.dart';

class BookSelectionPage extends StatelessWidget {
  final booklist =
      BooklistModel(t.booksLonewolf.books, lonewolfSupportedBooks, 'en')
          .getBooks();

  BookSelectionPage({Key? key}) : super(key: key);

// TODO - Handle error
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookSelectionViewModel>(
      converter: (store) => BookSelectionViewModel.create(store),
      builder: (BuildContext context, BookSelectionViewModel viewModel) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: viewModel.isLoading
                  ? const CircularProgressIndicator()
                  : BookSelection(
                      booklist, viewModel.selectedBook, viewModel.onSelectBook),
            ),
          ),
        );
      },
    );
  }
}
