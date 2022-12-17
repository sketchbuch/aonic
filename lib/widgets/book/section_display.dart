import 'package:flutter/material.dart';

import './get_tag_list.dart';
import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/section/section.dart';
import '../../types/types.dart';
import '../typography/headline.dart';

class SectionDisplay extends StatelessWidget {
  final transBook = t.book;
  final OnNavigate onNavigate;
  final Section section;

  SectionDisplay(this.section, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> sectionContent = getTagList(section.data.content, onNavigate);
    final List<Widget> subsectionContent = [];

    final subSections = section.getVisibleSubsections();

    if (subSections.isNotEmpty) {
      for (var subSection in subSections) {
        subsectionContent.add(Headline(
          subSection.meta.title,
          level: 2,
        ));
        subsectionContent.addAll(getTagList(subSection.data.content, onNavigate));
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Headline(
          section.isNumbered() ? transBook.headlineSection(sectionTitle: section.meta.title) : section.meta.title,
        ),
        ...sectionContent,
        ...subsectionContent,
      ],
    );
  }
}
