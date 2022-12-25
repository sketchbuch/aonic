import 'package:flutter/material.dart';

import '../../models/book/content/plain_list_tag.dart';
import '../../types/types.dart';
import '../content/tags/plain_list.dart';
import '../typography/headline.dart';

class NumberedSection extends StatelessWidget {
  final OnNavigate onNavigate;
  final BookText sectionTitle;
  final PlainListTag numberedSectionList;

  const NumberedSection(this.sectionTitle, this.numberedSectionList, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Headline(sectionTitle),
        PlainList(numberedSectionList, onNavigate),
      ],
    );
  }
}
