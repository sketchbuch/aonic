import 'package:flutter/material.dart';

import '../models/content/paragraph_tag.dart';
import '../models/content/tag.dart';

class Paragraph extends StatelessWidget {
  final Tag tag;

  const Paragraph(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paragraphTag = tag as ParagraphTag;

    return Row(children: paragraphTag.texts.map((text) => Text(text.text)).toList());
  }
}
