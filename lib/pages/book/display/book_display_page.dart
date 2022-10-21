import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../constants/books.dart';
import '../../../store/models/app_state.dart';
import '../../../widgets/content/text_paragraph.dart';
import '../../../widgets/matter/book_index.dart';
import '../../../widgets/matter/title_page.dart';
import '../../../widgets/numbered/book_display.dart';
import 'book_display_view_model.dart';

class BookDisplayPage extends StatelessWidget {
  const BookDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookDisplayViewModel>(
      converter: (store) => BookDisplayViewModel.create(store),
      builder: (BuildContext context, BookDisplayViewModel viewModel) {
        return Scaffold(
          body: Center(
            child: () {
              if (viewModel.isSection) {
                return BookDisplay(
                  viewModel.book,
                  viewModel.sectionNumber,
                  viewModel.onNavigate,
                );
              }

              switch (viewModel.pageId) {
                case bookIdTitle:
                  return TitlePage(viewModel.book.meta, viewModel.onNavigate);

                case bookIdStart:
                  return BookIndex(viewModel.book, viewModel.onNavigate);

                default:
                  return TextParagraph(
                      'Unknown matter id: "${viewModel.pageId}"');
              }
            }(),
          ),
        );
      },
    );
  }
}
