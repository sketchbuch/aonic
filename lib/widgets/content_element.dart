import 'package:flutter/material.dart';

import '../models/section/html_tag.dart';

class ContentElement extends StatelessWidget {
  final HtmlTag contentTag;

  const ContentElement(this.contentTag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (contentTag.type == HtmlTagType.element) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: contentTag.content.map((ele) => ContentElement(ele)).toList(),
      );
    }

    return Text(contentTag.text);
  }
}
