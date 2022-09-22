import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/meta.dart';
import '../../models/book/meta/right.dart';
import '../numbered/paragraph.dart';
import '../numbered/text_paragraph.dart';

class TitlePage extends StatelessWidget {
  final transBook = t.book;
  final Meta meta;

  TitlePage(this.meta, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextParagraph(meta.title),
        TextParagraph(meta.getCreator()),
        TextParagraph(transBook.publicationDate(date: meta.getFormattedPublicationDate())),
        ...meta.getDescriptionParagraphs().map((para) => Paragraph(para)),
        ...meta.getRightParagraphs(RightType.licenseNotification).map((para) => Paragraph(para)),
      ],
    );
  }
}
