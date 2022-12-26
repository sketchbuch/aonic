import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../constants/books.dart';
import '../../../constants/layout.dart';
import '../../../exceptions/render.dart';
import '../../../store/models/app_state.dart';
import '../../../widgets/content/tags/section.dart';
import '../../../widgets/matter/footnotes_list.dart';
import '../../../widgets/matter/numbered_section.dart';
import '../../../widgets/matter/title_page.dart';
import '../../../widgets/matter/toc_list.dart';
import 'book_display_view_model.dart';

class BookDisplayPage extends StatelessWidget {
  const BookDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookDisplayViewModel>(
      converter: (store) => BookDisplayViewModel.create(store),
      builder: (BuildContext context, BookDisplayViewModel viewModel) {
        final book = viewModel.book;

        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(paddingExtraLarge),
            child: () {
              if (viewModel.isLoading || book == null) {
                return const CircularProgressIndicator();
              } else {
                switch (viewModel.pageId) {
                  case bookIdToc:
                    return TocList(book.toc, viewModel.onNavigate);

                  case bookIdTitle:
                    return TitlePage(book.meta, viewModel.onNavigate);

                  default:
                    final section = book.getSection(viewModel.pageId);

                    if (section == null) {
                      throw RenderException('Unable to find section for display: "${viewModel.pageId}"');
                    }

                    if (viewModel.pageId == bookIdFootnotes) {
                      return FootnotesList(section, book.footnoteSections, viewModel.onNavigate);
                    } else if (viewModel.pageId == bookIdNumbered) {
                      return NumberedSection(section.meta.title, book.numberedSectionItems, viewModel.onNavigate);
                    }

                    return Section(section, viewModel.onNavigate, 1);
                }
              }
            }(),
          ),
        );
      },
    );
  }
}
