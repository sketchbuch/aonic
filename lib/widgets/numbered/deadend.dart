import 'package:flutter/material.dart';

import '../../models/book/content/deadend_tag.dart';
import '../content.dart';

class Deadend extends StatelessWidget {
  final DeadendTag tag;

  const Deadend(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Content(
      child: RichText(
        text: TextSpan(text: tag.text),
      ),
    );
  }
}
