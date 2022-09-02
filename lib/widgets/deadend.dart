import 'package:flutter/material.dart';

import '../models/book/content/deadend_tag.dart';
import 'content_renderer.dart';

class Deadend extends StatelessWidget with ContentRenderer {
  final DeadendTag tag;

  const Deadend(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return wrapContent(
      RichText(
        text: TextSpan(text: tag.text),
      ),
    );
  }
}
