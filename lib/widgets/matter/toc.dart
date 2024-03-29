import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/content/plain_list_tag.dart';
import '../../types/types.dart';
import '../content/plain_list.dart';
import '../typography/headline.dart';

class Toc extends StatelessWidget {
  final transBook = t.book;
  final PlainListTag toc;
  final OnNavigate onNavigate;

  Toc(this.toc, this.onNavigate, {Key? key}) : super(key: key);

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
