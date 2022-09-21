import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/meta.dart';
import '../../models/book/meta/right.dart';
import '../content_renderer.dart';
import 'paragraph_text_list.dart';

class TitlePage extends StatelessWidget with ContentRenderer {
  final transBook = t.book;
  final Meta meta;

  TitlePage(this.meta, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(meta.title),
        Text(meta.getCreator()),
        Text(transBook.publicationDate(date: DateFormat('dd/MM/yyyy').format(meta.publicationDate!))),
        ...meta.getDescriptionTexts().map((description) => ParagraphTextList(description)),
        ...meta.getRightTexts(RightType.licenseNotification).map((description) => ParagraphTextList(description)),
      ],
    );
  }
}
