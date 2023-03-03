import 'package:flutter/material.dart';

import '../../types/types.dart';
import '../layout/content_container.dart';
import '../mixins/content_renderer.dart';
import 'headline_text.dart';

class Headline extends StatelessWidget with ContentRenderer {
  final BookText text;
  final int? level;

  const Headline(
    this.text, {
    this.level = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: HeadlineText(
        text,
        level: level,
      ),
    );
  }
}
