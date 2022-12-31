import 'package:flutter/material.dart';

import '../../../constants/typography.dart';
import '../../../types/types.dart';
import '../../mixins/content_renderer.dart';
import '../../mixins/hoverable_text_element.dart';

const bulletSymbol = '\u2022';

class BulletListItem extends StatefulWidget with ContentRenderer {
  final int depth;
  final OnNavigate onNavigate;
  final List<Widget> content;

  const BulletListItem(this.content, this.onNavigate, this.depth, {Key? key}) : super(key: key);

  @override
  State<BulletListItem> createState() => _BulletListItemState();
}

class _BulletListItemState extends State<BulletListItem> with HoverableTextElement {
  @override
  Widget build(BuildContext context) {
    final depthIndent = widget.depth * listIndent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.depth > 1) SizedBox(width: depthIndent),
        const Text(bulletSymbol),
        const SizedBox(width: offsetMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.content,
          ),
        ),
      ],
    );
  }
}
