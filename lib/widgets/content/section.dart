import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../i18n/_generated_/translations.g.dart';
import '../../../models/book/content/section_tag.dart';
import '../../../types/types.dart';
import '../../config/config.dart';
import '../../store/models/app_state.dart';
import '../helpers/get_tag_list.dart';
import '../typography/headline.dart';
import 'footnotes.dart';
import 'section_view_model.dart';

class Section extends StatelessWidget {
  final transBook = t.book;
  final OnNavigate onNavigate;
  final SectionTag section;
  final int level;

  Section(this.section, this.onNavigate, this.level, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SectionViewModel>(
      converter: (store) => SectionViewModel.create(store),
      builder: (BuildContext context, SectionViewModel viewModel) {
        final bookConfig = config.getBookByCode(viewModel.bookCode);

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Headline(
              section.isNumbered() ? transBook.headlineSection(sectionTitle: section.meta.title) : section.meta.title,
              level: level,
            ),
            ...getTagList(section, onNavigate, level, bookConfig),
            if (section.footnotes.isNotEmpty) Footnotes(section.footnotes, onNavigate),
          ],
        );
      },
    );
  }
}
