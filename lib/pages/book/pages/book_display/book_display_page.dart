import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../../action_chart/ac.dart';
import '../../../../action_chart/data/action_chart_data.dart';
import '../../../../constants/books.dart';
import '../../../../constants/layout.dart';
import '../../../../exceptions/render.dart';
import '../../../../store/redux/models/app_state.dart';
import '../../../../widgets/action_chart/action_chart.dart';
import '../../../../widgets/content/section.dart';
import '../../../../widgets/layout/app_overlay.dart';
import '../../../../widgets/matter/footnotes.dart';
import '../../../../widgets/matter/numbered_sections.dart';
import '../../../../widgets/matter/title_page.dart';
import '../../../../widgets/matter/toc.dart';
import 'book_display_view_model.dart';

class BookDisplayPage extends StatefulWidget {
  const BookDisplayPage({Key? key}) : super(key: key);

  @override
  State<BookDisplayPage> createState() => _BookDisplayPageState();
}

class _BookDisplayPageState extends State<BookDisplayPage> {
  @override
  void initState() {
    super.initState();
    setupActionChart('lw', actionChart, actionChartData);
  }

  bool isAcVisible = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookDisplayViewModel>(
      converter: (store) => BookDisplayViewModel.create(store),
      builder: (BuildContext context, BookDisplayViewModel viewModel) {
        final book = viewModel.book;
        Widget pageWidget;

        if (viewModel.isLoading || book == null) {
          pageWidget = const CircularProgressIndicator();
        } else {
          if (viewModel.pageId == bookIdToc) {
            pageWidget = Toc(book.toc, viewModel.onNavigate);
          } else if (viewModel.pageId == bookIdTitle) {
            pageWidget = TitlePage(book.meta, viewModel.onNavigate);
          } else {
            final section = book.getSection(viewModel.pageId);

            if (section == null) {
              throw RenderException('Unable to find section for display: "${viewModel.pageId}"');
            }

            switch (viewModel.pageId) {
              case bookIdFootnotes:
                pageWidget = Footnotes(section.meta.title, viewModel.onNavigate, book.footnoteSections);
                break;

              case bookIdNumbered:
                pageWidget = NumberedSections(section.meta.title, viewModel.onNavigate, book.numberedSectionItems);
                break;

              default:
                pageWidget = Section(section, viewModel.onNavigate, 1);
                break;
            }
          }
        }

        return Portal(
          child: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(paddingExtraLarge),
                  child: pageWidget,
                ),
                if (viewModel.isActionChartVisible)
                  const AppOverlay(
                    child: ActionChart(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
