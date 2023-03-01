import 'package:flutter/material.dart';

import '../../constants/layout.dart';
import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/meta/meta_model.dart';
import '../../models/book/meta/right_model.dart';
import '../../types/types.dart';
import '../content/paragraph.dart';
import '../content/text_paragraph.dart';
import '../layout/dividing_line.dart';
import '../typography/headline.dart';

class TitlePage extends StatelessWidget {
  final transBook = t.book;
  final MetaModel meta;
  final OnNavigate onNavigate;

  TitlePage(this.meta, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Headline(meta.title),
        TextParagraph(meta.getCreator()),
        ...meta
            .getDescriptionParagraphs()
            .map((para) => Paragraph(para, onNavigate)),
        const DividingLine(),
        TextParagraph(transBook.publicationDate(
            date: meta.getFormattedPublicationDate())),
        ...meta
            .getRightParagraphs(RightType.licenseNotification)
            .map((para) => Paragraph(
                  para,
                  onNavigate,
                  bottomPadding: sizeZero,
                )),
        const SizedBox(height: paddingLarge),
      ],
    );
  }
}
