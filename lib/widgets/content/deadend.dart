import 'package:flutter/material.dart';

import '../../models/book/content/deadend_tag_model.dart';
import '../../constants/layout.dart';
import '../layout/content_container.dart';

class Deadend extends StatelessWidget {
  final DeadendTagModel tag;
  final double bottomPadding;

  const Deadend(this.tag, {Key? key, this.bottomPadding = paddingLarge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      bottomPadding: bottomPadding,
      child: RichText(
        text: TextSpan(text: tag.text),
      ),
    );
  }
}
