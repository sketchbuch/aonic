import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../constants/books.dart';
import '../../../exceptions/render.dart';
import '../../../store/models/app_state.dart';
import '../../../widgets/matter/book_index_page.dart';
import '../../../widgets/matter/matter_display.dart';
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
              switch (viewModel.pageId) {
                case bookIdTitle:
                  return TitlePage(viewModel.book.meta, viewModel.onNavigate);

                case bookIdStart:
                  return BookIndexPage(viewModel.book.bookIndex, viewModel.onNavigate);

                default:
                  final section = viewModel.book.getSection(
                    viewModel.pageId,
                    viewModel.isSection ? viewModel.sectionNumber : null,
                  );

                  if (section == null) {
                    throw RenderException('Unable to find section for display: "${viewModel.pageId}"');
                  }

                  if (viewModel.isSection) {
                    return BookDisplay(section, viewModel.onNavigate);
                  }

                  return MatterDisplay(section, viewModel.onNavigate);
              }
            }(),
          ),
        );
      },
    );
  }
}
