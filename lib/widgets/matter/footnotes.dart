import 'package:flutter/material.dart';

import '../../models/book/section/footnote_model.dart';
import '../../types/types.dart';
import '../content/list/footnotes_list_item.dart';
import '../layout/content_container.dart';
import '../typography/headline.dart';

class Footnotes extends StatelessWidget {
  final List<FootnoteModel> footnotes;
  final OnNavigate onNavigate;
  final BookText sectionTitle;

  const Footnotes(this.sectionTitle, this.onNavigate, this.footnotes,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Headline(sectionTitle),
          ...footnotes
              .map((footnote) => FootnotesListItem(footnote, onNavigate)),
        ],
      ),
    );
  }
}
