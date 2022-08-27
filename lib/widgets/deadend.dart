import 'package:flutter/material.dart';

import '../models/content/deadend_tag.dart';

class Deadend extends StatelessWidget {
  final DeadendTag tag;

  const Deadend(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: tag.text),
    );
  }
}
