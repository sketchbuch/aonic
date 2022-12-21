import 'package:flutter/material.dart';

import '../../../i18n/_generated_/translations.g.dart';
import '../../../models/book/content/section_tag.dart';
import '../../../types/types.dart';
import '../../book/get_tag_list.dart';
import '../../typography/headline.dart';

class Section extends StatelessWidget {
  final transBook = t.book;
  final OnNavigate onNavigate;
  final SectionTag section;

  Section(this.section, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Headline(
          section.isNumbered() ? transBook.headlineSection(sectionTitle: section.meta.title) : section.meta.title,
        ),
        ...getTagList(section.data.content, onNavigate),
      ],
    );
  }
}
