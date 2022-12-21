import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/content/plain_list_tag.dart';
import '../../types/types.dart';
import '../content/tags/plain_list.dart';
import '../typography/headline.dart';

class TocList extends StatelessWidget {
  final transBook = t.book;
  final PlainListTag toc;
  final OnNavigate onNavigate;

  TocList(this.toc, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Headline(transBook.pageTtles.tableOfContents),
        PlainList(toc, onNavigate),
      ],
    );
  }
}
