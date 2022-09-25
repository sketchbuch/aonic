import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/book.dart';
import '../content/content_container.dart';

class BookIndex extends StatelessWidget {
  final transBook = t.book;
  final Book book;

  BookIndex(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookIndex = book.getBookIndex();

    return ContentContainer(
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: bookIndex.map((item) {
            if (item.isSubItem == true) {
              return TextSpan(
                text: ' ----- ${item.label}',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('ID: "${item.id}"');
                  },
              );
            }

            return TextSpan(
              text: item.label,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('ID: "${item.id}"');
                },
            );
          }).toList(),
        ),
      ),
    );
  }
}
