import 'package:flutter/material.dart';

import '../../models/book/content/section_tag.dart';
import '../../models/book/section/footnote.dart';
import '../../types/types.dart';
import '../content/list/footnotes_list_item.dart';
import '../layout/content_container.dart';
import '../typography/headline.dart';

class FootnotesList extends StatelessWidget {
  final List<Footnote> footnotes;
  final OnNavigate onNavigate;
  final SectionTag footnoteSection;

  const FootnotesList(this.footnoteSection, this.footnotes, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int footnoteNumber = 1;
    List<FootnotesListItem> footnoteItems = [];

    for (var footnote in footnotes) {
      footnoteItems.add(FootnotesListItem(footnote, footnoteNumber, onNavigate));
      footnoteNumber += 1;
    }

    return ContentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Headline(footnoteSection.meta.title),
          ...footnoteItems,
        ],
      ),
    );
  }
}
