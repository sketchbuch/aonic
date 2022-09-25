import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/meta/meta.dart';
import '../../models/book/meta/right.dart';
import '../../types/types.dart';
import '../content/tags/paragraph.dart';
import '../content/text_paragraph.dart';

class TitlePage extends StatelessWidget {
  final transBook = t.book;
  final Meta meta;
  final OnNavigate onNavigate;

  TitlePage(this.meta, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextParagraph(meta.title),
        TextParagraph(meta.getCreator()),
        TextParagraph(transBook.publicationDate(date: meta.getFormattedPublicationDate())),
        ...meta.getDescriptionParagraphs().map((para) => Paragraph(para, onNavigate)),
        ...meta.getRightParagraphs(RightType.licenseNotification).map((para) => Paragraph(para, onNavigate)),
      ],
    );
  }
}
