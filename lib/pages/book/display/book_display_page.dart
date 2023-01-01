import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../constants/books.dart';
import '../../../constants/layout.dart';
import '../../../exceptions/render.dart';
import '../../../store/redux/models/app_state.dart';
import '../../../widgets/content/section.dart';
import '../../../widgets/matter/footnotes.dart';
import '../../../widgets/matter/numbered_sections.dart';
import '../../../widgets/matter/title_page.dart';
import '../../../widgets/matter/toc.dart';
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
              }

              if (viewModel.pageId == bookIdToc) {
                return Toc(book.toc, viewModel.onNavigate);
              } else if (viewModel.pageId == bookIdTitle) {
                return TitlePage(book.meta, viewModel.onNavigate);
              } else {
                final section = book.getSection(viewModel.pageId);

                if (section == null) {
                  throw RenderException('Unable to find section for display: "${viewModel.pageId}"');
                }

                switch (viewModel.pageId) {
                  case bookIdFootnotes:
                    return Footnotes(section.meta.title, viewModel.onNavigate, book.footnoteSections);

                  case bookIdNumbered:
                    return NumberedSections(section.meta.title, viewModel.onNavigate, book.numberedSectionItems);

                  default:
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
