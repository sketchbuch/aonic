import 'package:flutter/material.dart';

import './get_tag_list.dart';
import '../../models/book/section/section.dart';
import '../../types/types.dart';

class SectionDisplay extends StatelessWidget {
  final OnNavigate onNavigate;
  final Section section;

  const SectionDisplay(this.section, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> sectionContent = getTagList(section.data.content, onNavigate);
    final List<Widget> subsectionContent = [];

    final subSections = section.getVisibleSubsections();

    if (subSections.isNotEmpty) {
      for (var subSection in subSections) {
        subsectionContent.addAll(getTagList(subSection.data.content, onNavigate));
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(section.meta.title),
        ...sectionContent,
        ...subsectionContent,
      ],
    );
  }
}
