import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../constants/books.dart';
import '../../../exceptions/render.dart';
import '../../../store/models/app_state.dart';
import '../../../widgets/matter/book_index.dart';
import '../../../widgets/matter/title_page.dart';
import '../../../widgets/numbered/book_display.dart';
import 'book_display_view_model.dart';

class BookDisplayPage extends StatelessWidget {
  const BookDisplayPage({Key? key}) : super(key: key);

  Widget getPageWidget(BookDisplayViewModel viewModel) {
    final book = viewModel.book;
    final isSection = viewModel.isSection;
    final meta = book.meta;
    final pageId = viewModel.pageId;
    final sectionNumber = viewModel.sectionNumber;

    if (isSection || pageId == bookIdNumbered) {
      return BookDisplay(book, sectionNumber, viewModel.onNavigate);
    }

    switch (pageId) {
      case bookIdTitle:
        return TitlePage(meta, viewModel.onNavigate);

      case bookIdStart:
        return BookIndex(viewModel.book, viewModel.onNavigate);

      default:
        print('### Unknown matter id: "$pageId"');
        throw RenderException('Unknown matter id: "$pageId"');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookDisplayViewModel>(
      converter: (store) => BookDisplayViewModel.create(store),
      builder: (BuildContext context, BookDisplayViewModel viewModel) {
        return Scaffold(
          body: Center(
            child: getPageWidget(viewModel),
          ),
        );
      },
    );
  }
}
