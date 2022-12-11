import 'package:flutter/material.dart';

import '../../../models/book/content/description_list_tag.dart';
import '../content_container.dart';

class DescriptionList extends StatelessWidget {
  final DescriptionListTag tag;

  const DescriptionList(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: RichText(
        text: const TextSpan(text: 'DescriptionList'),
      ),
    );
  }
}
