import 'package:flutter/material.dart';

import '../../constants/layout.dart';
import '../layout/content_container.dart';

class TextParagraph extends StatelessWidget {
  final double bottomPadding;
  final String text;

  const TextParagraph(this.text, {Key? key, this.bottomPadding = paddingLarge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      bottomPadding: bottomPadding,
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(text: text, style: const TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.normal))
          ],
        ),
      ),
    );
  }
}
