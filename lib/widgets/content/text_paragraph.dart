import 'package:flutter/material.dart';

import 'content_container.dart';

class TextParagraph extends StatelessWidget {
  final String text;

  const TextParagraph(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
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
