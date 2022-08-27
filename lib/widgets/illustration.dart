import 'package:flutter/material.dart';

import '../models/content/illustration_tag.dart';

class Illustration extends StatelessWidget {
  final IllustrationTag tag;

  const Illustration(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: [
        TextSpan(text: 'Illustration: "${tag.creator}"'),
      ],
    ));
  }
}
