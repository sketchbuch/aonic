import 'package:flutter/material.dart';

import '../../../i18n/_generated_/translations.g.dart';
import '../../../models/book/content/section_tag.dart';
import '../../../types/types.dart';
import '../../helpers/get_tag_list.dart';
import '../../typography/headline.dart';

class Section extends StatelessWidget {
  final transBook = t.book;
  final OnNavigate onNavigate;
  final SectionTag section;
  final int level;

  Section(this.section, this.onNavigate, this.level, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Headline(
          section.isNumbered() ? transBook.headlineSection(sectionTitle: section.meta.title) : section.meta.title,
          level: level,
        ),
        ...getTagList(section.data.content, onNavigate, level),
      ],
    );
  }
}
