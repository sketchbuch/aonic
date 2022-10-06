import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../constants/books.dart';
import '../../../exceptions/render.dart';
import '../../../store/models/app_state.dart';
import '../../../widgets/frontmatter/book_index.dart';
import '../../../widgets/frontmatter/title_page.dart';
import '../../../widgets/numbered/book_display.dart';
import 'book_display_view_model.dart';

class BookDisplayPage extends StatelessWidget {
  const BookDisplayPage({Key? key}) : super(key: key);

  Widget getPageWidget(BookDisplayViewModel viewModel) {
    final book = viewModel.book;
    final meta = book.meta;
    final isSection = viewModel.isSection;
    final pageId = viewModel.pageId;
    final sectionNumber = viewModel.sectionNumber;

    if (isSection) {
      return Text('Section needs displaying: "$sectionNumber"');
    }

    switch (pageId) {
      case 'numbered':
        return BookDisplay(book, sectionNumber, viewModel.onNavigate);

      case 'title':
        return TitlePage(meta, viewModel.onNavigate);

      case bookStartPage:
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
