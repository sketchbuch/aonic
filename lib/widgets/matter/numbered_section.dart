import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../models/book/content/section_tag.dart';
import '../../types/types.dart';

class NumberedSection extends StatelessWidget {
  final OnNavigate onNavigate;
  final SectionTag numberedSection;
  final List<SectionTag> numberedSections;

  const NumberedSection(this.numberedSection, this.numberedSections, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const blockSize = 10;
    final blocks = numberedSections.slices(blockSize);
    var prevBlock = 0;
    var blockNumber = 1;

    /* for (var block in blocks) {
      print('###########################');
      print('### Block: $blockIndex');
      print('### ======');

      for (var section in block) {
        print('### - Section "${section.meta.title}"');
      }

      print('###########################');
    } */

    return Column(
      children: blocks.map<Widget>((sectionList) {
        final blockStart = prevBlock + 1;
        final blockEnd = blockNumber * blockSize;

        prevBlock = blockEnd;
        blockNumber += 1;

        for (var section in sectionList) {}

        return Text('$blockStart-$blockEnd:');
      }).toList(),
    );
  }
}
