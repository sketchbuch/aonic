import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/books.dart';
import '../../constants/layout.dart';
import '../../constants/typography.dart';
import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/content/subcontent/numbered_section_item.dart';
import '../../theme/theme.dart';
import '../../types/types.dart';
import '../helpers/limit_range.dart';
import '../layout/content_container.dart';
import '../typography/headline.dart';

class NumberedSection extends StatefulWidget {
  final transBook = t.book;
  final OnNavigate onNavigate;
  final BookText sectionTitle;
  final List<NumberedSectionItem> numberedSections;

  NumberedSection(this.sectionTitle, this.numberedSections, this.onNavigate, {Key? key}) : super(key: key);

  @override
  State<NumberedSection> createState() => _NumberedSectionState();
}

class _NumberedSectionState extends State<NumberedSection> {
  String term = '';

  @override
  Widget build(BuildContext context) {
    final visibleSections = term.isEmpty
        ? widget.numberedSections
        : widget.numberedSections.where((section) => section.title.startsWith(term)).toList();
    final itemCount = visibleSections.length;

    return ContentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Headline(widget.sectionTitle),
          TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: widget.transBook.numberedSection.searchField.hintText,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LimitRange(pageMin, pageMax)],
            maxLength: 3,
            onChanged: (value) {
              if (mounted) {
                setState(() => term = value);
              }
            },
          ),
          const SizedBox(height: offsetLarge),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 3 / 1,
              crossAxisSpacing: paddingLarge,
              mainAxisSpacing: paddingLarge,
            ),
            itemBuilder: (BuildContext ctx, index) {
              final section = visibleSections[index];

              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: colourSplash, borderRadius: BorderRadius.circular(borderRaius)),
                child: Text(section.title),
              );
            },
            itemCount: itemCount,
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
