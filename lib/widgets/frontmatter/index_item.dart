import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/index/book_index_item.dart';
import '../../types/types.dart';
import '../content/content_container.dart';
import '../mixins/content_renderer.dart';

class IndexItem extends StatefulWidget with ContentRenderer {
  final transBook = t.book;
  final BookIndexItem item;
  final OnNavigate onNavigate;

  IndexItem(this.item, this.onNavigate, {Key? key}) : super(key: key);

  @override
  State<IndexItem> createState() => _IndexItemState();
}

class _IndexItemState extends State<IndexItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final label = widget.item.isSubItem
        ? ' ----- ${widget.item.label}'
        : widget.item.label;

    return ContentContainer(
      bottomPadding: 4.0,
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              onEnter: (_) => setState(() => _hover = true),
              onExit: (_) => setState(() => _hover = false),
              text: label,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  widget.onNavigate(widget.item.id);
                },
              style: TextStyle(
                backgroundColor: _hover ? hoverBackgroundColour : null,
                decoration: TextDecoration.underline,
              ),
            )
          ].toList(),
        ),
      ),
    );
  }
}
